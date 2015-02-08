var test = require('tape');
var server = require("../"); // require index.js


test("GET timer /timer/{id?} should fail (at first)", function(t) {
  var options = {
    method: "GET",
    url: "/timer/1"
  };
  // server.inject lets you similate an http request
  server.inject(options, function(response) {
    t.equal(response.statusCode, 404, "No records at startup");
    t.end();
  });
});

test("POST timer /timer should create a new timer", function(t) {
  var options = {
    method: "POST",
    url: "/timer",
    data: {author:null, text:null}
  };
  // server.inject lets you similate an http request
  server.inject(options, function(response) {
    t.equal(response.statusCode, 400, "New timer fails validation");
    t.end();
    server.stop();
  });
});
