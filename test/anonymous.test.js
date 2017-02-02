var test   = require('tape');
var server = require("../server.js");
// var JWT    = require('jsonwebtoken');
var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";

test(file + "GET / Confirm the API server is working", function(t) {
  var options = {
    method: "GET",
    url: "/"
  };
  server.inject(options, function(response) {
    t.equal(response.statusCode, 200, "Welcome Stranger!");
    server.stop(function(){});
    t.end();
  });
});
/*
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
    console.log(file+' - - - - - - - - - OPTIONS:');
    console.log(options);

    // server.inject(options, function(res) {
    //   console.log(' - - - - - - - - - - - - - - - res.payload:')
    //   console.log(res.payload);
    //   console.log(' - - - - - - - - - - - - - - - - - - - - - -')
    //   var T = JSON.parse(res.payload);
    //   t.equal(res.statusCode, 200, "New timer started! " + T.start);
      server.stop(function(){
        redisClient.quit();
        t.end();
        console.log('ended?')
      });
      // t.end();
    // });
  });
});
*/
test.onFinish(function () {
  server.stop(function(){});
})

process.on('uncaughtException', function(err) {
  console.log(file+' FAIL ... ' + err);
  process.exit();
});
