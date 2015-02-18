var test = require('tape');
var server = require("../server.js");

test("Warm Up the Engine", function(t) {
  var options = {
    method: "GET",
    url: "/home"
  };
  // server.inject lets us similate an http request
  server.inject(options, function(response) {
    t.equal(response.statusCode, 200, "Welcome to Timer Land");
    t.end();
  });
});


test("GET timer /timer/{id?} should fail (at first)", function(t) {
  var options = {
    method: "GET",
    url: "/timer/1"
  };
  // server.inject lets us similate an http request
  server.inject(options, function(response) {
    t.equal(response.statusCode, 404, "No records at startup");
    t.end();
  });
});

test("POST timer /timer/new should FAIL when supplied bad payload", function(t) {
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
    t.equal(response.statusCode, 400, "New timer FAILS validation: "
      + response.result.message);
    t.end();
    server.stop();
  });
});
