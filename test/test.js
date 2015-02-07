var test = require('tape');
var server = require("../"); // require index.js

console.log('this should print');
test("GET timer /timer/{id?} should fail (at first)", function(t) {
  var options = {
    method: "GET",
    url: "/timer/1"
  };
  // server.inject lets you similate an http request
  server.inject(options, function(response) {
    t.equal(response.statusCode, 404);
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
    t.equal(response.statusCode, 400);
    t.end();
    server.stop();
  });
});
