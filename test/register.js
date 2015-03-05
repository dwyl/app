var test   = require('tape');
var server = require("../server.js");

test("Bad request to /register (should fail)", function(t) {
  var options = {
    method  : "POST",
    url     : "/register",
  };
  // server.inject lets us similate an http request
  server.inject(options, function(res) {
    // console.log(" - - - - - - - - - - - - ");
    // console.dir(res.result);
    // console.log(" - - - - - - - - - - - - ");
    t.equal(res.statusCode, 400, "No payload submitted");
    t.end();
    server.stop();
  });
});

test("Register a new person", function(t) {
  var person = {
    "email"    : "anabella.tester@awesome.net",
    "password" : "PinkFluffyUnicorns"
  }
  var options = {
    method  : "POST",
    url     : "/register",
    payload : person
  };
  // server.inject lets us similate an http request
  server.inject(options, function(res) {
    t.equal(res.statusCode, 200, "Person registration is succesful");
    t.end();
    server.stop();
  });
});

test("Attempt to register the same person twice", function(t) {
  var person = {
    "email"    : "anabella.tester@awesome.net",
    "password" : "PinkFluffyUnicorns"
  }
  var options = {
    method  : "POST",
    url     : "/register",
    payload : person
  };
  // server.inject lets us similate an http request
  server.inject(options, function(res) {
    t.equal(res.statusCode, 400, "Person registration fails");
    t.end();
    server.stop();
  });
});



// use this while developing registration then comment out
// as we already have a test/z_teardown.jss
var drop = require('./z_drop');
test("Registration Teardown", function(t) {
  drop(function(res){
    t.equal(res.acknowledged, true, "All Records Deleted ;-)");
    t.end();
  }).end();
});
