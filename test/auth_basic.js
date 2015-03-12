var test   = require('tape');
var server = require("../server.js");
var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";
// console.log(" - - - - - - - - -> test/auth_basic.js <- - - - - - - - -");
test(test + "POST /login 401 for un-registered person", function(t) {
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

test(file + "Create a new person and log in", function(t) {
  var email      = "auth_basic.tester@awesome.net";
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
    // setTimeout(function() { // give ES a chance to index the person record
      server.inject(options2, function(res) {
        // console.log(file + " - - - - - - - - - - - - /login res");
        // console.dir(res.payload); // auth header
        // // console.log(" - - - - - - - - - - - - ");
        t.equal(res.statusCode, 200, "Login Success!!");
        t.end();
        server.stop();
      });
    // },200);

  });
});

var drop = require('./z_drop');
test(file + "Teardown", function(t) {
  drop(function(res){
    t.equal(res.acknowledged, true, "All Records Deleted ;-)");
    t.end();
  }).end();
});
