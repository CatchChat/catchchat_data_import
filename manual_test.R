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

ag1 <- mongo.bson.from.JSON('{"$group":{"_id": {"ord_date": {"day": {"$dayOfMonth": "$created_at"}}}}}')
#ag1 <- mongo.bson.from.JSON('{"$group": {"_id":null, "count": {"$sum":1}}}')
print(count)

bson <- mongo.aggregation(mongo, "catch_chat.users", list(ag1))
