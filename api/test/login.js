var test   = require('tape');
var server = require("../../web.js");
// https://nodejs.org/docs/latest/api/globals.html#globals_require_cache
var uncache = require('./uncache').uncache;
var redisClient = require('../lib/redis_connection');


var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";

var email  = 'dwyl.test+auth_basic' +Math.random()+'@gmail.com';

test(file + "POST /login 401 for un-registered person", function(t) {
  var email      = "unregistered@awesome.io";
  var password   = "PinkFluffyUnicorns";
  var authHeader = "Basic " + (new Buffer(email + ':' + password, 'utf8')).toString('base64');
  var options    = {
    method  : "POST",
    url     : "/login",
    headers : { authorization : authHeader }
  };
  server.inject(options, function(res) {
    t.equal(res.statusCode, 401, "Unregistered Cannot Login");
    t.end();
    server.stop();
  });
});

test(file + "Create new person " +email +" and log in", function(t) {
  var password   = "PinkFluffyUnicorns";
  var options = {
    method  : "POST",
    url     : "/register",
    payload : { email: email, password: password }
  };
  server.inject(options, function(res) {
    t.equal(res.statusCode, 200, "Person registration is succesful");
    var authHeader = "Basic " + (new Buffer(email + ':' + password, 'utf8')).toString('base64');
    var options2    = {
      method  : "POST",
      url     : "/login",
      headers : { authorization : authHeader }
    };
    server.inject(options2, function(res) {
      // console.log(' - - - - - - - - - - - - - - - - - - - - - - ')
      // console.log(res.result)
      // console.log(' - - - - - - - - - - - - - - - - - - - - - - ')
      t.equal(res.statusCode, 200, "Login Success!!");
      t.end();
      server.stop();
    });
  });
});

test(file + "Attempt to /login using incorrect password", function(t) {
  var password   = "WatchItFail!";
  var authHeader = "Basic " + (new Buffer(email + ':' + password, 'utf8')).toString('base64');
  var options2    = {
    method  : "POST",
    url     : "/login",
    headers : { authorization : authHeader }
  };
  server.inject(options2, function(res) {
    console.log(res.result)
    t.equal(res.statusCode, 401, "Fails (as expected) MSG: " + res.result.message);
    t.end();
  });
});

// tape doesn't have a "after" function. see: http://git.io/vf0BM - - - - - - \\
// so... we have to add this test to *every* file to tidy up. - - - - - - - - \\
test(file + " cleanup =^..^= \n", function(t) { // - - - - - - - - - -  - - - \\
  var uncache = require('./uncache').uncache;   // http://goo.gl/JIjK9Y - - - \\
  require('../lib/redis_connection').end();     // ensure redis con closed! - \\
  uncache('../lib/redis_connection');           // uncache redis con  - - - - \\
  server.stop();                                // stop the mock server.  - - \\
  uncache('../../web.js');      // uncache web.js to ensure we reload it. - - \\
  t.end();                      // end the tape test.   - - - - - - - - - - - \\
}); // tedious but necessary  - - - - - - - - - - - - - - - - - - - - - - - - \\
