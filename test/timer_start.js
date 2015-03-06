var test = require('tape');
var server = require("../server.js");
var token; // used below

test("POST /timer/new should FAIL when no Auth Token Sent", function(t) {
  var options = {
    method: "POST",
    url: "/timer/new",
    payload: {
      "ct" : "fail", // we don't allow people/apps to set the created time!
      "desc" : "its time!"
    }
  };
  // server.inject lets us similate an http request
  server.inject(options, function(response) {
    t.equal(response.statusCode, 401, "New timer FAILS JTW Auth: "
      + response.result.message);
    t.end();
    server.stop();
  });
});

var secret = 'NeverShareYourSecret'; // @todo use ENV var for this
var JWT    = require('jsonwebtoken');
var token  = JWT.sign({pica:"boo"}, secret); // synchronous


test("POST /timer/new should FAIL when supplied bad payload", function(t) {
  var options = {
    method: "POST",
    url: "/timer/new",
    payload: {
      "ct" : "fail", // we don't allow people/apps to set the created time!
      "desc" : "its time!"
    },
    headers : {
      authorization : token
    }
  };
  // server.inject lets us similate an http request
  server.inject(options, function(response) {
    t.equal(response.statusCode, 400, "New timer FAILS validation: "
      + response.result.message);
    t.end();
    server.stop();
  });
});


test("START a NEW Timer (no st sent by client)!", function(t) {
  var timer = {
    "desc" : "Get the Party Started!"
  }

  var options = {
    method: "POST",
    url: "/timer/new",
    payload: timer,
    headers : {
      authorization : token
    }
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
    payload: timer,
    headers : {
      authorization : token
    }
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
