// Logout https://github.com/ideaq/time/issues/65
var test   = require('tape');
var server = require("../server.js");
var token;   // used below
var timerid; // used below

test("test/logout.js -> /register new person and log in", function(t) {
  var email      = "anthony.tester@awesome.net";
  var password   = "PinkFluffyUnicorns";
  var options = {
    method  : "POST",
    url     : "/register",
    payload : { email: email, password: password }
  };
  // server.inject lets us similate an http request
  server.inject(options, function(res) {
    t.equal(res.statusCode, 200, "Person registration is succesful");

    //information required for logging in user
    var authHeader = "Basic " + (new Buffer(email + ':' + password, 'utf8')).toString('base64');
    var options2    = {
      method  : "POST",
      url     : "/login",
      headers : {
        authorization : authHeader
      }
    };
    // login with the user we created above
    server.inject(options2, function(res) {
      // console.log("test/logout.js ->  res.headers.authorization:");
      // console.dir(res.headers.authorization); // auth header
      // console.log(" - - - - - - - - - - - - ");
      token = res.headers.authorization
      t.equal(res.statusCode, 200, "Login Success!!");
      t.end();
      server.stop();
    });

  });
});

test("test/logout.js -> New person creates a NEW TIMER", function(t) {
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

test("test/logout.js -> LOGOUT", function(t) {
  var options = {
    method: "POST",
    url: "/logout",
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

test("test/logout.js -> Confirm Logged out person CANNOT CREATE", function(t) {
  var timer = {
    "desc" : "This should not be permitted!"
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
    t.equal(res.statusCode, 401, "New timer started! " + T.st);
      t.end();
      server.stop();
    // });
  });
});

test("test/logout.js -> Confirm Logged out person CANNOT ACCESS valid TIMER", function(t) {
  var options = {
    method: "GET",
    url: "/timer/"+timerid,
    headers : { authorization : token }
  };
  // server.inject lets us similate an http request
  server.inject(options, function(response) {
    // console.log(response);
    t.equal(response.statusCode, 401, "Invalid JWT (person logged out)");
    t.end();
    server.stop();
  });
});
