// delete the records we created in test/register.js and test/timer_*.js
// so that the person/timers do not exist next time we run the tests.
var test = require('tape');

test("Taredown", function(t) {
  var options = {
      host:"127.0.0.1",
      port: 9200, // use ENV var?
      path: "/_all", // DELETEs EVERYTHING!!
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json'
      }
    };

  var http = require('http');

  var resStr = '';
  // Set up the request
  http.request(options, function(res) {
    res.setEncoding('utf8');
    var resStr = '';
    res.on('data', function (chunk) {
      resStr += chunk;
    }).on('end', function () {
      // console.log("Taredown "+ resStr);
      t.equal(JSON.parse(resStr).acknowledged, true, "All Records Deleted");
      t.end();
    }).on('error', function(err){
      console.log("FAIL: "+err);
    })
  }).end();
});
