var test   = require('tape');
var server = require("../server.js");
var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";

var drop = require('./z_drop');
test(file + "Logout Teardown", function(t) {
  drop(function(res){
    t.equal(res.acknowledged, true, "All Records Deleted ;-)");
    t.end();
  }).end();
});

var JWT  = require('jsonwebtoken'); // https://github.com/docdis/learn-json-web-tokens


test(file + "GET timer /timer/1 (invalid timer id) should return 404", function(t) {
  var options = { method : "GET", url : "/anonymous" };
  server.inject(options, function(res) {
    // t.equal(res.statusCode, 200, res.result);
    var token = res.headers.authorization;
    var options = {
      method: "GET",
      url: "/timer/1",
      headers : { authorization : token }
    };
    var decoded = JWT.verify(token, process.env.JWT_SECRET);
    console.log(file + " - - - - - - - - - - decoded token:")
    console.log(decoded);
    console.log("     ") // blank line
    setTimeout(function() { // give (TRAVIS!!!) ES a chance to index the session record
      server.inject(options, function(response) {
        console.log(response.payload);
        // I think this should be a 404 error, but for now the auth plugin gives 401.
        t.equal(response.statusCode, 404, "Record did not exist, as expected");
        t.end();
        server.stop();
      });
    }, process.env.TRAVIS_TIMEOUT || 1);
  });
});
