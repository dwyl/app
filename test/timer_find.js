var test   = require('tape');
var server = require("../server.js");
var secret = 'NeverShareYourSecret'; // @todo use ENV var for this
var JWT    = require('jsonwebtoken');
var token  = JWT.sign({pica:"boo"}, secret); // synchronous

test("GET timer /timer/1 (invalid timer id) should return 404", function(t) {
  var options = {
    method: "GET",
    url: "/timer/1",
    headers : { authorization : token }
  };
  // server.inject lets us similate an http request
  server.inject(options, function(response) {
    // console.log(response);
    t.equal(response.statusCode, 404, "No records at startup");
    t.end();
    server.stop();
  });
});
