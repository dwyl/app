var Lab = require("lab");
var lab = exports.lab = Lab.script();
var expect = require('code').expect;
var suite = lab.suite;
var test = lab.test;
var server = require("../"); // require index.js

suite("Basic HTTP Tests", function() {
    // tests
  test("GET timer /timer/{id?} should fail (at first)", function(done) {
    var options = {
      method: "GET",
      url: "/timer/1"
    };
        // server.inject lets you similate an http request
    server.inject(options, function(response) {
      expect(response.statusCode).to.equal(404);  //  Expect http response status code to be 200 ("Ok")
   // Lab.expect(response.result).to.have.length(12); // Expect result to be "Hello Timmy!" (12 chars long)
      done();                                         // done() callback is required to end the test.
    });
  });

  test("POST timer /timer should create a new timer", function(done) {
    var options = {
      method: "POST",
      url: "/timer",
      data: {author:null, text:null}
    };
        // server.inject lets you similate an http request
    server.inject(options, function(response) {
      expect(response.statusCode).to.equal(400);  //  Expect http response status code to be 200 ("Ok")
   // Lab.expect(response.result).to.have.length(12); // Expect result to be "Hello Timmy!" (12 chars long)
      done();                                         // done() callback is required to end the test.
    });
  });



});
