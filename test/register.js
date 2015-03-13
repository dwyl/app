var test   = require('tape');
var server = require("../server.js");
var dir   = __dirname.split('/')[__dirname.split('/').length-1];
var file  = dir + __filename.replace(__dirname, '');

test(file+"Bad request to /register (should fail)", function(t) {
  var options = {
    method  : "POST",
    url     : "/register"
  };
  server.inject(options, function(res) {
    t.equal(res.statusCode, 400, "No payload submitted");
    t.end();
    server.stop();
  });
});

test(file+"Register a new person", function(t) {
  var person = {
    "email"    : "anabella.tester@awesome.net",
    "password" : "PinkFluffyUnicorns"
  }
  var options = {
    method  : "POST",
    url     : "/register",
    payload : person
  };
  server.inject(options, function(res) {
    t.equal(res.statusCode, 200, "Person registration is succesful");
    t.end();
    server.stop();
  });
});

test(file+"Attempt to register the same person twice", function(t) {
  var person = {
    "email"    : "anabella.tester@awesome.net",
    "password" : "PinkFluffyUnicorns"
  }
  var options = {
    method  : "POST",
    url     : "/register",
    payload : person
  };
  server.inject(options, function(res) {
    t.equal(res.statusCode, 400, "Person registration fails");
    t.end();
    server.stop();
  });
});

test(file+"Attempt to register with short password", function(t) {
  var person = {
    "email"    : "another.tester@awesome.net",
    "password" : "123"
  }
  var options = {
    method  : "POST",
    url     : "/register",
    payload : person
  };
  server.inject(options, function(res) {
    t.equal(res.statusCode, 400, "Longer password required");
    t.end();
    server.stop();
  });
});
