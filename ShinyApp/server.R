#
# ShinyMongo App
# a simple R based MongoDB - Viewer
# 

library(shiny)
library(rmongodb)
library(rjson)
library(RJSONIO)
library(ggplot2)
#RJSONIO gets problems with big JSON objects )-:

# parameter to set the maximum queyering and displaying lentgth
limit <- 100L


shinyServer(function(input, output) {
  
  # create mongo connection
  connection <- reactive({
    mongo <- mongo.create(input$host, username=input$username, password=input$password)
  })
  
  ####################
  # sidebar rendering
  ####################
  
  # render database input field
  output$dbs <- renderUI({
    mongo <- connection()
    if (mongo.is.connected(mongo)) {
      dbs <- mongo.get.databases(mongo)
      selectInput("db_input", "Database", dbs)
    }
  })
  
  # render collection input field
  output$collections <- renderUI({
    mongo <- connection()
    if (mongo.is.connected(mongo)) {
      if( !is.null(input$db_input) ){
        collections <- mongo.get.database.collections(mongo, input$db_input)
        selectInput("collections_input", "Collections", c("-",collections))
      }
    }
  })
  
  # render query input field
  output$query <- renderUI({  
    mongo <- connection()
    if (mongo.is.connected(mongo)) {
      if( !is.null(input$collections_input)){
        if( !is.null(input$db_input) && input$collections_input!="-" ){
          textInput("query", "JSON Query - experimental:", "")
        }
      }
    }
  })
  
  
  ####################
  # output / main window rendering
  ####################
  
  # display text for connection information / error
  output$connection <- renderText({
    mongo <- connection()
    if (mongo.is.connected(mongo)) {
      str <- mongo.get.primary(mongo)
      paste("Connected to ", str , sep="")
    } else {
      # ToDo: more detailed errors
      paste("Unable to connect.  Error code:", mongo.get.err(mongo))
    }
  })
  
  # display collection data as JSON output
  output$view <- renderText({
    mongo <- connection()
    if (mongo.is.connected(mongo)) {
    
      if( !is.null(input$query) ){
        if( input$query !="" ){
          Rquery <- rjson::fromJSON(input$query)
          print(class(Rquery))
          query <- mongo.bson.from.list(Rquery)
        } else {
          buf <- mongo.bson.buffer.create()
          query <- mongo.bson.from.buffer(buf)
        }
      }
        
      if( !is.null(input$collections_input) && !is.null(input$query) ){
        cursor <- mongo.find(mongo, input$collections_input, query, limit=limit)
        res_list <- list()
        tmp_all <- NULL
        i <- 1
       while (mongo.cursor.next(cursor)){
         tmp <- mongo.cursor.value(cursor)
         res_list[[i]] <- mongo.bson.to.list(tmp)
         i <- i+1
       }
       mongo.cursor.destroy(cursor)
        json <- RJSONIO::toJSON(res_list)
        json <- gsub("\\},\\{", "},<br><br>{", json)
       return( json )
      }
    }
  })
  
  # display Headline for collection data output
  output$view_head <- renderText({
    mongo <- connection()
    if (mongo.is.connected(mongo)) {
      if( !is.null(input$collections_input) && input$collections_input != "-" ){
        count <- mongo.count(mongo, input$collections_input)
        if (count < limit)
          limit <- count
        paste("Documents (", limit, " out of ",count,")", sep="")
      }
    }
  })
  
  # display table with collection overview
  output$view_collections <- renderTable({
    mongo <- connection()
    if( mongo.is.connected(mongo) ) {
      if( !is.null(input$db_input) ){
        coll <- mongo.get.database.collections(mongo, input$db_input)
        
        res <- NULL
        for(i in coll){
          val <- mongo.count(mongo, i)
          tmp <- cbind(i,val)
          res <- rbind(res, tmp)
        }
        if( !is.null(res) )
          colnames(res) <- c("collection", "# documents")
        
        return(res)
      }
    } 
  })
 output$plotUserDaily <- renderPlot({
   db_input <- "catch_chat"
   mongo <- connection()
   dbs <- mongo.get.databases(mongo)
   collections <- mongo.get.database.collections(mongo, db_input)
   start_date_string <- "2014-10-03"
   end_date_string <- "2014-10-04"
   query <- mongo.bson.from.list(list(created_at= list("$gt"= as.POSIXct(start_date_string),"$lt"= as.POSIXct(end_date_string))))
   print(query)
   count <- mongo.count(mongo, "catch_chat.users", query=query)
   
   # db.users.aggregate({$group:{_id: {"month": {$month: "$created_at"}}, count:{$sum:1}}}, {$sort:{"_id.month":1}})
   
   # db.users.aggregate({$group:{_id: {"day": {$dayOfMonth: "$created_at"},"month": {$month: "$created_at"}}, count:{$sum:1}}}, {$sort:{"_id.month":1, "_id.day":1}})
   ag1 <- mongo.bson.from.JSON('
                               {"$group":
                                 {"_id": 
                                   {"day": {"$dayOfMonth": "$created_at"},
                                    "month": {"$month": "$created_at"}
                                   },
                                   "count": {"$sum": 1}
                                 }
                               } ')
                              
   ag2 <- mongo.bson.from.JSON('
                               {
                                 "$sort": { 
                                   "_id.month":1,
                                   "_id.day":1
                                 }
                               }
                               ')
   #ag1 <- mongo.bson.from.JSON('{"$group": {"_id":null, "count": {"$sum":1}}}')
   print(count)
   
   bson <- mongo.aggregation(mongo, "catch_chat.users", list(ag1, ag2))
   lresult <- mongo.bson.value(bson,"result")
   mresult <- sapply(lresult,function(x) return(c(x$'_id',x$count)))
   
   library(reshape2)
   
   df <- as.data.frame(t(mresult))
   colnames(df) <-c("day", "month", "new_user_count")
   
   df.long <-melt(df,id.vars=c("month","day"), measure.vars=c("new_user_count"))
   df.long<-transform(df.long,dat=as.Date(paste(day,month,sep="/"),"%d/%m"))
   df.long <- df.long[order(df$month,df$day),]
   print(
     plot(df.long$dat, df.long$value,type="b")
   )
 
 })

})
