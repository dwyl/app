var test   = require('tape');
var server = require("../server.js");
var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";
var token;

test(file + "POST /timer/new should FAIL when no Auth Token Sent", function(t) {
  var options = { method : "GET", url : "/anonymous" };
  server.inject(options, function(res) {
    // t.equal(res.statusCode, 200, res.result);
    token = res.headers.authorization;
    var options = {
      method: "POST",
      url: "/timer/new",
      payload: {
        "ct" : "fail", // we don't allow people/apps to set the created time!
        "desc" : "its time!"
      }
    };
    setTimeout(function() { // give ES a chance to index the person record
      server.inject(options, function(response) {
        t.equal(response.statusCode, 401, "New timer FAILS JTW Auth: "
          + response.result.message);
        t.end();
        server.stop();
      });
    },200);
  });
});

test(file + "POST /timer/new should FAIL when supplied valid token but bad payload", function(t) {
  var options = {
    method: "POST",
    url: "/timer/new",
    payload: {
      "ct" : "fail", // we don't allow people/apps to set the created time!
      "desc" : "its time!"
    },
    headers : { authorization : token }
  };
  // server.inject lets us similate an http request
  server.inject(options, function(response) {
    // console.log(file + " response: " )
    // console.log(response.result)
    t.equal(response.statusCode, 400, "New timer FAILS validation: "
      + response.result.message);
    t.end();
    server.stop();
  });
});


test(file + "START a NEW Timer (no st sent by client)!", function(t) {
  var timer = {
    "desc" : "Get the Party Started!"
  }

  var options = {
    method: "POST",
    url: "/timer/new",
    payload: timer,
    headers : { authorization : token }
  };
  // server.inject lets us similate an http request
  server.inject(options, function(res) {
    var T = JSON.parse(res.payload);
    t.equal(res.statusCode, 200, "New timer started! " + T.st);
    // confirm the Timer started
    var tid = T._id;
    // console.dir(T);
    var options = {
      method: "GET",
      url: "/timer/"+tid,
      payload: timer,
      headers : {
        authorization : token
      }
    };
    server.inject(options, function(res) {
      t.equal(res.statusCode, 200, "New timer retrieved!");
      t.end();
      server.stop();
    });
  });
});

test(file + "START a NEW Timer with start time!", function(t) {
  var timer = {
    "desc" : "We're going to Ibiza!",
    "st" : new Date().toISOString()
  }

  var options = {
    method: "POST",
    url: "/timer/new",
    payload: timer,
    headers : { authorization : token }
  };
  // server.inject lets us similate an http request
  server.inject(options, function(res) {
    var T = JSON.parse(res.payload);
    t.equal(res.statusCode, 200, "New timer started! " + T.st);
      t.end();
      server.stop();
    // });
  });
});

// use this while developing registration then comment out
// as we already have a test/z_teardown.jss
// var drop = require('./z_drop');
// test(file + "Logout Teardown", function(t) {
//   drop(function(res){
//     t.equal(res.acknowledged, true, "All Records Deleted ;-)");
//     t.end();
//   }).end();
// });
