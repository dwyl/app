// delete the records we created in test/register.js and test/timer_*.js
// so that the person/timers do not exist next time we run the tests.
var test = require('tape');
var helpers = require('./_test_drop');
// var uncache = require('./uncache').uncache;
// var redisClient = require('../lib/redis_connection');

test("Teardown", function(t) {
  helpers.drop(function(res){
    console.log(res);
    t.equal(res.acknowledged, true, "ALL Records DELETED!");
    // redisClient.end();
    // uncache('../lib/redis_connection'); // uncache redis connection!
    t.end();
  }).end();
});
