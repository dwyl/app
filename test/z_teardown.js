// delete the records we created in test/register.js and test/timer_*.js
// so that the person/timers do not exist next time we run the tests.
var test = require('tape');
var drop = require('./z_drop');
test("Teardown", function(t) {
  drop(function(res){
    t.equal(res.acknowledged, true, "ALL Records DELETED!");
    t.end();
  }).end();
});
