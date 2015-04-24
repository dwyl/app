
var test   = require('tape');
var server = require("../../web.js");
var JWT    = require('jsonwebtoken');
var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";

// test(file + "GET / Confirm the API server is working", function(t) {
//   var options = {
//     method: "GET",
//     url: "/"
//   };
//   server.inject(options, function(response) {
//     t.equal(response.statusCode, 200, "Welcome to Timer Land Anonymous person!");
//     t.end();
//   });
// });

test(file + "Anonymous people can create timers!", function(t) {
  var options    = {
    method  : "GET",
    url     : "/anonymous"
  };
  server.inject(options, function(res) {
    console.log(' - - - - - - - - - - - - - - - res.result:')
    console.log(res.result);
    console.log(' - - - - - - - - - - - - - - - - - - - - - -')

    t.equal(res.statusCode, 200, "Session Created = "+res.result.created);
    var token = res.headers.authorization;
    var decoded = JWT.decode(token, process.env.JWT_SECRET); // http://git.io/xPBn
    console.log(decoded);
    var timer = {
      "desc" : "Anonymous people deserve a voice too!",
      "start" : new Date().toISOString()
    }
    var options = {
      method: "POST",
      url: "/timer/new",
      payload: timer,
      headers : { authorization : token }
    };
    console.log(file+' - - - - - - - - - OPTIONS');
    console.log(options);

    server.inject(options, function(res) {
      console.log(' - - - - - - - - - - - - - - - res.payload:')
      console.log(res.payload);
      console.log(' - - - - - - - - - - - - - - - - - - - - - -')
      var T = JSON.parse(res.payload);
      t.equal(res.statusCode, 200, "New timer started! " + T.start);
      t.end();
    });
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

process.on('uncaughtException', function(err) {
  console.log(file+' FAIL ... ' + err);
});
