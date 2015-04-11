var test   = require('tape');
var JWT    = require('jsonwebtoken');
var server = require("../../web.js");
var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";
var email  = "n"+Math.random()+"@awesome.net"

var person = {
  "email"    : email,
  "password" : "SoCloseTo10kh!"
}
var token;
var tid;
test(file + "Anonymous person can creates a timer, then register", function(t) {
  var options    = {
    method  : "GET",
    url     : "/anonymous"
  };
  server.inject(options, function(res) {
    t.equal(res.statusCode, 200, "Session Created = "+res.result.created);
    token = res.headers.authorization;
var decoded = JWT.verify(token, process.env.JWT_SECRET);
console.log(" - - - - - - - - - - - - - - - - - - - decoded: ")
console.log(decoded);
console.log(" - - - - - - - - - - - - - - - - - - - ")
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
      // console.log(file+" - - - - anonymous person's timer:")
      // console.log(T.id);
      tid = T.id; // save this to lookup below
      // console.log(" - - - - - - - - - - - - - - - - - - - ")
      t.equal(res.statusCode, 200, "New timer started! " + T.start);
      t.equal(T.desc, timer.desc, "New timer desc: " + timer.desc);
      t.end();
    }); // end inject /timer/new
  });
});

test(file + "Transfer records created by anon to registered person", function(t){
  var options = {
    method  : "POST",
    url     : "/register",
    headers : { authorization : token },
    payload : person
  };
  setTimeout(function(){
    server.inject(options, function(res) {
      t.equal(res.statusCode, 200, "Person registration is succesful");
      console.log(res.result);
      // now create a new record with the new Session Token
      token = res.headers.authorization;
      console.log(token);
// var decoded = JWT.verify(token, process.env.JWT_SECRET);
// console.log(" - - - - - - - - - - - - - - - - - - - decoded: ")
// console.log(decoded);
// console.log(" - - - - - - - - - - - - - - - - - - - ")
      var timer = {
        "desc" : "Everything is Awesome Sauce",
        "start" : new Date().toISOString()
      }
      var options = {
        method: "POST",
        url: "/timer/new",
        payload: timer,
        headers : { authorization : token }
      };
      server.inject(options, function(res2) {
        var T = JSON.parse(res2.payload);
        // console.log(file+" - - - - anonymous person's timer:")
        // console.log(T.id);
        tid = T.id; // save this to lookup below
        console.log(" - - - - - - - - - - - - - - - - - - - ")
        console.log(res2.result);
        t.equal(res2.statusCode, 200, "New timer started! " + T.start);
        t.equal(T.desc, timer.desc, "New timer desc: " + timer.desc);
        t.end();
      }); // end inject /timer/new
    });
  },2000);
})

var aguid = require('aguid');

test(file + "Lookup the timer confirm the person is set", function(t){
  var personid = aguid(email);
  var options = {
    method  : "GET",
    url     : "/timer/"+tid,
    headers : { authorization : token }
  };
  // console.log("URL: "+options.url);
  setTimeout(function(){
    server.inject(options, function(res) {
      // console.log(" - - -  person should not be anonymous anymore")
      // console.log(res.result);
      t.equal(res.result.person, personid, "Timer");
      t.end();
      server.stop();
    });
  },1000);
})

var drop = require('./z_drop');
// test("Teardown", function(t) {
//   drop(function(res){
//     t.equal(res.acknowledged, true, "ALL Records DELETED!");
//     t.end();
//   }).end();
// });
