# mysql = require 'mysql'

# class MyDatabase
#   getUserStatuses: (request, response) ->
#   # // var query = 'select * from user_table;';
#   # // client.query(
#   # //   query,
#   # //   function selectCb(err, results, fields) {
#   # //     res.send(results);
#   # //   });
#   var samples = [
#     [34.268288,135.151928,"ユーザ1",1],
#     [34.267929,135.151586,"ユーザ2",2],
#     [34.268227,135.151855,"ユーザ3",1]];

#   var results = [];
#   var i;
#   for (i = 0;i < samples.length;i++) {
#     results.push({
#       x: samples[i][0],
#       y: samples[i][1],
#       userName: samples[i][2],
#       faceId: samples[i][3]
#       });

#   res.send(results);

# # // function (request, response) {

# # // }

# function setOrUpdateUserStatus(request, response) {
#   var query = format2string('select * from user_table where userId=%1;',
#                             request.body.userId);
#   client.query(query, function selectCb(err, results, fields) {
#     if (err) {
#       console.log("error");
#       // var query = format2string('insert into user_table values(%4,
#       //                           request.body.x, request.body.y,
#       //                           request.body.faceId, request.body.userId);

#       // client.query(query,function selectCb(err, results, fields) {
#       //   res.send(results);
#       // });

#       throw err;
#     }
#     var query = format2string('update user_table set x=%1, y=%2, faceId=%3 where userId=%4;',
#                               request.body.x, request.body.y,
#                               request.body.faceId, request.body.userId);

#     client.query(query,function selectCb(err, results, fields) {
#       res.send(results);
#     });
#   });
# }

# function test(request, response) {
#   response.writeHead(200, {'Content-Type': 'text/plain'});
#   response.write('Hello World!!\n');
#   response.end();
# }

# function initDatabase(request, response) {
#   //  client.query('drop table user_table;');
#   client.query('create table user_table (id int primary key auto_increment, name char(30), date Date, face int, x int, y int);');

#   response.writeHead(200, {'Content-Type': 'text/plain'});
#   response.write('Database initialization completed!!\n');
#   response.end();
# }

# module.exports = new zecun.StrUtil();