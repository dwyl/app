var test   = require('tape');
var server = require("../server.js");
// var perma  = require('perma');

test("POST /login 401 for un-registered person", function(t) {
  var email      = "unregistered@awesome.io";
  var password   = "PinkFluffyUnicorns";
  var authHeader = "Basic " + (new Buffer(email + ':' + password, 'utf8')).toString('base64');
  var options    = {
    method  : "POST",
    url     : "/login",
    headers : {
      authorization : authHeader
    }
  };
  // server.inject lets us similate an http request
  server.inject(options, function(res) {
    // console.log(" - - - - - - - - - - - - ");
    // console.dir(res.result); // show boom result from hapi-auth-basic
    // console.log(" - - - - - - - - - - - - ");
    t.equal(res.statusCode, 401, "Unregistered Cannot Login");
    t.end();
    server.stop();
  });
});

test("Create a new user and log in", function(t) {
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
      console.log(" - - - - - - - - - - - - ");
      console.dir(res.headers.authorization); // auth header
      console.log(" - - - - - - - - - - - - ");
      t.equal(res.statusCode, 200, "Login Success!!");
      t.end();
      server.stop();
    });

  });
});
