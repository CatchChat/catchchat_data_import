library(rmongodb)
library(rjson)
#library(RJSONIO)
library(ggplot2)
db_input <- "catch_chat"
mongo <- mongo.create()
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
mresult <- sapply(result,function(x) return(c(x$'_id',x$count)))
