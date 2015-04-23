// delete the records we created in test/register.js and test/timer_*.js
// so that the person/timers do not exist next time we run the tests.
var test = require('tape');
var helpers = require('./_test_drop');

test("Teardown", function(t) {
  helpers.drop(function(res){
    console.log(res);
    t.equal(res.acknowledged, true, "ALL Records DELETED!");
    t.end();
  }).end();
});

// tape doesn't have a "after" function. see: http://git.io/vf0BM - - - - - - \\
// so... we have to add this test to *every* file to tidy up. - - - - - - - - \\
test(file + " cleanup =^..^= \n", function(t) { // - - - - - - - - - -  - - - \\
  var uncache = require('./uncache').uncache;   // http://goo.gl/JIjK9Y - - - \\
  require('../lib/redis_connection').end();     // ensure redis con closed! - \\
  uncache('../lib/redis_connection');           // uncache redis con  - - - - \\
  t.end();                      // end the tape test.   - - - - - - - - - - - \\
}); // tedious but necessary  - - - - - - - - - - - - - - - - - - - - - - - - \\
