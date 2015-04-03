var test   = require('tape');
var server = require("../../web.js");
var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";
var token;
var records = 100;
var countdown = records;

var drop = require('./z_drop');
test(file+ "Teardown", function(t) {
  drop(function(res){
    t.equal(res.acknowledged, true, file+"ALL Records DELETED!");
    t.end();
  }).end();
});

function create(t, callback) {
  var timer = {
    "desc" : "My Amazing Timer #"+countdown,
    "start" : new Date().toISOString()
  }
  var options = {
    method: "POST",
    url: "/timer/new",
    payload: timer,
    headers : { authorization : token }
  };
  server.inject(options, function(res) {
    countdown--;
    // console.log(" >>> "+countdown + " res.created "+ T.created);
    if(countdown === 0) {
      var T = JSON.parse(res.payload);
      t.equal(res.statusCode, 200, records+ " New timers started! " + T.start);
      callback(res, t);
    }
  });
}

function finish(res, t){
  // console.log(res);
  var T = JSON.parse(res.payload);
  var tid = T.id;
  var options = {
    method: "GET",
    url: "/timer/"+tid,
    headers : { authorization : token }
  };

  server.inject(options, function(res) {
    t.equal(res.statusCode, 200, "New timer retrieved!"+'\n');
    server.stop();
    t.end();
  });
}

test(file + "Register new person to create a few timers", function(t) {
  var person = {
    "email"    : "multiple.timers@awesome.net",
    "password" : "EveryThingisAwesome",
    "firstname": "Jenny"
  }
  var options = {
    method  : "POST",
    url     : "/register",
    payload : person
  };
  server.inject(options, function(res) {
    console.log(res.result);
    t.equal(res.statusCode, 200, "Session Created = "+res.result.created);
    token = res.headers.authorization;
    // can't create create functions inside a for loop so no anon callbacks!
    for(var i = 0; i < records; i++) {
      create(t, finish);
    } // end for
  });
});

test(file + "GET /timer/all to list all timers", function(t) {
  var options = {
    method: "GET",
    url: "/timer/all",
    headers : { authorization : token }
  };
  setTimeout(function(){
    server.inject(options, function(res) {
      // console.log(res.result);
      var T = JSON.parse(res.payload);
      t.equal(res.statusCode, 200, "Find all records for this person");
      t.true(T.hits.total > 97, "TRAVIS (Free/Slow) ElasticSearch (ONLY) Found: "+T.hits.total);
      server.stop();
      t.end();
    });
  },1000)
});

test(file + "GET /timer/all should fail for Timmy no timers", function(t) {
  var person = {
    "email"    : "timmy.no.timers@awesome.net",
    "password" : "EveryThingisAwesome"
  }
  var options = {
    method  : "POST",
    url     : "/register",
    payload : person
  };
  server.inject(options, function(res) {
    var newtoken = res.headers.authorization;
    var options = {
      method: "GET",
      url: "/timer/all",
      headers : { authorization : newtoken }
    };
    setTimeout(function(){
      server.inject(options, function(res) {
        console.log(res.result);
        var T = JSON.parse(res.payload);
        console.log(T);
        t.equal(res.statusCode, 404, "Timmay! has no timers...");
        // t.equal(T.hits.total, 100, "100 records found");
        server.stop();
        t.end();
      });
    },1000)
  });
});
