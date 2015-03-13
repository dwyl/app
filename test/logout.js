// Logout https://github.com/ideaq/time/issues/65
var ES     = require('esta');
var test   = require('tape');
var server = require("../server.js");
var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";
var token;   // used below
var timerid;
var JWT  = require('jsonwebtoken'); // https://github.com/docdis/learn-json-web-tokens



test(file + "/register + login new person and log in", function(t) {
  var email      = "a"+(Math.floor(Math.random() * 6) + 1) + "@awesome.net";
  console.log(file + " email address to register: "+email);
  var password   = "PinkFluffyUnicorns";
  var options = {
    method  : "POST",
    url     : "/register",
    payload : { email: email, password: password }
  };
  // server.inject lets us similate an http request
  server.inject(options, function(res) {
    t.equal(res.statusCode, 200, "Person registration is succesful");
    // console.log(file + " - - - - - - - - - - - - ");
    // console.log(res.headers.authorization);
    token = res.headers.authorization
    var decoded = JWT.verify(token, process.env.JWT_SECRET);
    console.log(file + " - - - - - - - - - - decoded token:")
    console.log(decoded);
    console.log("     ") // blank line
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
    setTimeout(function() { // give the session record time to propagate in Cluster
      server.inject(options, function(res) {
        console.log(file + " - - - - - - - - - - /timer/new res:")
        console.log(res.payload);
        console.log("     ") // blank line

        var T = JSON.parse(res.payload);
        t.equal(res.statusCode, 200, "New timer started! " + T.st);
        t.end();
        server.stop();
      });
    }, process.env.TIMEOUT || 1);
  });
});



test(file + "LOGOUT", function(t) {
  var options = {
    method: "POST",
    url: "/logout",
    headers : { authorization : token }
  };
  // server.inject lets us similate an http request
  server.inject(options, function(res) {
    // var T = JSON.parse(res.payload);
    console.log(file + " - - - - - - - - - - - - /logout res:");
    console.log(res.result);
    t.equal(res.statusCode, 200, "/logout worked");

    var ses = { "index":"time", "type":"session", "id":res.result._id }
    ES.READ(ses, function(record){
      console.log("   ") // blank line
      console.log(file + " - - - - - - - - - - - - ");
      console.log(record._source);
      console.log("   ") // blank line

      // t.end();
      // server.stop();
      var options = {
        method: "POST",
        url: "/timer/new",
        payload: { "desc" : "This should not be permitted!" },
        headers : { authorization : token }
      };
      // server.inject lets us similate an http request
      server.inject(options, function(res) {
        console.log(file + " - - - - - - - - - - - - ");
        console.log(res.result);
        console.log("   ") // blank line

        t.equal(res.statusCode, 401, "Cannot create after logout");
          t.end();
          server.stop();
        // });
      });
    })
    // });
  });
});

test(file + "Confirm Logged out person CANNOT CREATE", function(t) {
  var timer = {
    "desc" : "This should not be permitted!"
  }
  var options = {
    method: "POST",
    url: "/timer/new",
    payload: timer,
    headers : { authorization : token }
  };
  // server.inject lets us similate an http request
  server.inject(options, function(res) {
    console.log(file + " - - - - - - - - - - - - /timer/new res (should be 401 cause we logged out!)");
    console.log(res.result);
    console.log("   ") // blank line
    t.equal(res.statusCode, 401, "New timer started! ");
      t.end();
      server.stop();
    // });
  });
});

test("test/logout.js -> /timer/:id ... Confirm Logged out person CANNOT ACCESS valid TIMER", function(t) {
  var options = {
    method: "GET",
    url: "/timer/"+timerid,
    headers : { authorization : token }
  };
  // server.inject lets us similate an http request
  server.inject(options, function(response) {
    console.log(file + " - - - - - - - - - - - - /timer/id res (should be 401 ... logged out!)");
    console.log(response.result);
    t.equal(response.statusCode, 401, "Invalid JWT (person logged out)");
    t.end();
    server.stop();
  });
});


// use this while developing registration then comment out
// as we already have a test/z_teardown.js
var drop = require('./z_drop');
test(file + "Logout Teardown", function(t) {
  drop(function(res){
    t.equal(res.acknowledged, true, "All Records Deleted ;-)");
    t.end();
  }).end();
});
