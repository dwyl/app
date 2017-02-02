// delete the records we created in test/register.js and test/timer_*.js
// so that the person/timers do not exist next time we run the tests.
var test = require('tape');
test("Teardown", function(t) {
  t.assert(true, 'done');
  t.end();
});

test.onFinish(function () {
  process.exit();
});
