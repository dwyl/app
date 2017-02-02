/*
// Logout https://github.com/ideaq/time/issues/65
var ES     = require('esta');
var test   = require('tape');
var server = require("../../web.js");

var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";
var token;   // used below
var timerid;

test(file + "/register + login new person", function(t) {
  var email  = 'dwyl.test+logout' +Math.random()+'@gmail.com';
  var password   = "PinkFluffyUnicorns";
  var options = {
    method  : "POST",
    url     : "/register",
    payload : { email: email, password: password }
  };
  server.inject(options, function(res) {
    t.equal(res.statusCode, 200, "Person registration is succesful");
    token = res.headers.authorization
    t.ok(token.length > 50, "Auth Token was set");
    var timer = {
      "desc" : "Everything is Awesome! http://youtu.be/81QMiGhIymU"
    }
    var options = {
      method: "POST",
      url: "/timer/new",
      payload: timer,
      headers : { authorization : token }
    };
    server.inject(options, function(res) {
      // console.log('\n - - - - - - - - - -  /timer/new res')
      // console.log(res.result)
      // console.log(' - - - - - - - - - - - - - - - \n')
      timerid = res.result.id; // used to confirm logged out cannot access
      t.equal(res.statusCode, 200, "New timer started! " + res.result.start);
      t.end();
      server.stop();
    });
  });
});

test(file + "LOGOUT", function(t) {
  var options = {
    method: "POST",
    url: "/logout",
    headers : { authorization : token }
  };
  console.log(options);
  server.inject(options, function(res) {

    t.equal(res.statusCode, 200, "/logout worked");
    var ses = { "index":"time", "type":"session", "id":res.result.id }

    ES.READ(ses, function(record){
      var options = {
        method: "POST",
        url: "/timer/new",
        payload: { "desc" : "This should not be permitted!" },
        headers : { authorization : token }
      };
      server.inject(options, function(res) {
        t.equal(res.statusCode, 401, "Cannot create after logout");
        t.end();
        server.stop();
      });
    })
  });
});

test(file + "Confirm Logged out person CANNOT CREATE", function(t) {
  var timer = { "desc" : "This should not be permitted!" }
  var options = {
    method: "POST",
    url: "/timer/new",
    payload: timer,
    headers : { authorization : token }
  };
  server.inject(options, function(res) {
    t.equal(res.statusCode, 401, "New timer started! ");
    t.end();
    server.stop();
  });
});

test("test/logout.js -> /timer/:id ... Confirm Logged out person CANNOT ACCESS valid TIMER", function(t) {
  var options = {
    method: "GET",
    url: "/timer/"+timerid,
    headers : { authorization : token }
  };
  server.inject(options, function(response) {
    t.equal(response.statusCode, 401, "Invalid JWT (person logged out)");
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
*/
