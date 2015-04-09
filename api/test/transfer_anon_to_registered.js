var test   = require('tape');
var server = require("../../web.js");
var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";
var token;
test(file + "Anonymous person can creates a timer, then register", function(t) {
  var options    = {
    method  : "GET",
    url     : "/anonymous"
  };
  server.inject(options, function(res) {
    t.equal(res.statusCode, 200, "Session Created = "+res.result.created);
    token = res.headers.authorization;
    var timer = {
      "desc" : "Just chillin'...",
      "start" : new Date().toISOString()
    }
    var options = {
      method: "POST",
      url: "/timer/new",
      payload: timer,
      headers : { authorization : token }
    };
    server.inject(options, function(res) {
      var T = JSON.parse(res.payload);
      console.log(file+" - - - - anonymous person's timer:")
      console.log(T);
      console.log(" - - - - - - - - - - - - - - - - - - - ")
      t.equal(res.statusCode, 200, "New timer started! " + T.start);
      t.equal(T.desc, timer.desc, "New timer desc: " + timer.desc);
      t.end();
    }); // end inject /timer/new
  });
});

test(file + "Register anon", function(t){
  var person = {
    "email"    : Math.random()+"@awesome.net",
    "password" : "SoCloseTo10kh!"
  }
  var options = {
    method  : "POST",
    url     : "/register",
    headers : { authorization : token },
    payload : person
  };
  setTimeout(function(){
    server.inject(options, function(res) {
      console.log(res.result);
      t.equal(res.statusCode, 200, "Person registration is succesful");
      t.end();
      server.stop();
    });
  },1000);
})

var drop = require('./z_drop');
test("Teardown", function(t) {
  drop(function(res){
    t.equal(res.acknowledged, true, "ALL Records DELETED!");
    t.end();
  }).end();
});
