var express = require('express');
var http = require('http');
var app = module.exports = express.createServer();
var mysql = require('mysql');
var HOSTNAME = 'localhost';
var DBNAME = 'gtug_hackathon1';
var DBUSER = 'root';
var DBPASSWD = "kmkzhvn";
var client = mysql.createClient({
  user: DBUSER,
  password: DBPASSWD,
  host: HOSTNAME ,
  database: DBNAME
});

var ICON_DIR = 'http://ec2-175-41-232-72.ap-northeast-1.compute.amazonaws.com:3000/icon1/';
var ICON_TABLE = [ICON_DIR + 'icon1.png',
                  ICON_DIR + 'icon3.png',
                  ICON_DIR + 'icon4.png',
                  ICON_DIR + 'icon2.png',
                  ICON_DIR + 'icon5.png'];

// Configuration
app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'ejs');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser());
  // app.use(express.session({
  //   store: store, 
  //   secret: "keyboard cat",
  //   cookie: { httpOnly: false }}));
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true })); 
});

app.configure('production', function(){
  app.use(express.errorHander()); 
});

app.get('/', showPage);
app.get('/init_database', initDatabase);
app.post('/get_user_statuses', getUserStatuses);
app.get('/set_user_status', setOrUpdateUserStatus);
//app.post('/login_or_create_user', loginOrCreateUser);

function showPage(request, response) {
  response.render('index',{});
}

function getUserStatuses(request, response) {
  var query = 'select * from user_table;';
  client.query(
    query,
    function selectCb(err, results, fields) {
      var i;
      for (i = 0;i < results.length;i++) {
        results[i].userName = results[i].name;
        results[i].faceId = ICON_TABLE[results[i].faceId];
      }
      console.log(results);
      response.send(results);
    });
  
  // var samples = [
  //   [34.268288,135.151928,"ユーザ1",1],
  //   [34.267929,135.151586,"ユーザ2",2],
  //   [34.268227,135.151855,"ユーザ3",1]];

  // var results = [];
  // var i;
  // for (i = 0;i < samples.length;i++) {
  //   results.push({
  //     x: samples[i][0],
  //     y: samples[i][1],
  //     userName: samples[i][2],
  //     faceId: samples[i][3]     
  //     });
  // }
  // console.log(results);
  // response.send(results);
}

// function (request, response) {

// }

function setOrUpdateUserStatus(request, response) {
  console.log(request);
  // var query = format2string('select * from user_table where userId=%1;',
  //                           request.body.userId);
  // client.query(query, function selectCb(err, results, fields) {
  //   if (err) {
  //     console.log("error");
  //     // var query = format2string('insert into user_table values(%4, 
  //     //                           request.body.x, request.body.y,
  //     //                           request.body.faceId, request.body.userId);
  
  //     // client.query(query,function selectCb(err, results, fields) {
  //     //   res.send(results);      
  //     // });
  
  //     throw err;
  //   }
  var query = format2string('update user_table set x=%1, y=%2, date=CURTIME(), faceId=%3 where id=%4;',
                            request.query.x, request.query.y,
                            request.query.faceId, request.query.userId);

  console.log(query);
  
  client.query(query,function selectCb(err, results, fields) {
    // response.writeHead(200, {'Content-Type': 'text/plain'});
    // response.write('Database initialization completed!!\n');
    // response.end();
    response.redirect('/');
    //response.send(results);      
  });
  // });
}

function test(request, response) {
  response.writeHead(200, {'Content-Type': 'text/plain'});
  response.write('Hello World!!\n');
  response.end();
}

function initDatabase(request, response) {
  //client.query('drop table user_table;');
  client.query('create table user_table (id int primary key auto_increment, name char(30), date Time, faceId int, x double, y double);', function() {
    console.log('test');
    var samples = [
      [34.268288,135.151928,"ユーザ1",1],
      [34.267929,135.151586,"ユーザ2",2],
      [34.268227,135.151855,"ユーザ3",1],
      [34.996632,135.743283,"ユーザ4",3],
      [34.989873,135.749956,"ユーザ6",4],
      [34.994531,135.746469,"ユーザ7",4],
      [34.995779,135.738916,"ユーザ8",4],
      [34.989873,135.749956,"ユーザ9",4],
      [34.99461,135.743401,"ユーザ10",4],
      [34.994276,135.739721,"ユーザ11",4]
    ];

    var i;
    var queries = [];
    for (i = 0;i < samples.length;i++){
      var s = samples[i];
      queries.push(format2string('insert into user_table values(NULL, "%1", CURTIME(), %2, %3, %4);',
                                 s[2], s[3], s[0], s[1]));
    }

    sequenciallyWrite(queries, function() {
      response.writeHead(200, {'Content-Type': 'text/plain'});
      response.write('Database initialization completed!!\n');
      response.end();
    });
  });
}

function sequenciallyWrite(queries, lastCallback){
  function recursion() {
    if (queries.length === 0) {
      lastCallback();
    } else {
      var query = queries.pop();
      console.log(query);
      client.query(query,function selectCb(err, results, fields) {
        recursion();
      });
    }
  }

  recursion();
}

function format2string(string) {
  if (arguments.length === 0) {
    throw 'Argument Exception';
  }
  var i;
  for (i = 0; i < arguments.length; i++) {
    string = string.replace('%' + i, arguments[i]);
  }
  return string;
}

app.listen(3000);