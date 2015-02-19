var test = require('tape');
var server = require("../server.js");

test("START a NEW Timer!", function(t) {
  var timer = {
    "desc" : "Get the Party Started!"
  }

  var options = {
    method: "POST",
    url: "/timer/new",
    payload: timer
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
      payload: timer
    };
    server.inject(options, function(res) {
      // console.log(" - - - - - - - - ");
      // console.dir(res.payload);
      // console.log(" - - - - - - - - ");
      t.equal(res.statusCode, 200, "New timer retrieved!");
      t.end();
      server.stop();
    });
  });
});

test("START a NEW Timer with start time!", function(t) {
  var timer = {
    "desc" : "We're going to Ibiza!",
    "st" : new Date().toISOString()
  }

  var options = {
    method: "POST",
    url: "/timer/new",
    payload: timer
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
