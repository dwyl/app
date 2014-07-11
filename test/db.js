// var couchbase = require('couchbase');
// var cluster = new couchbase.Cluster();
// var db = cluster.openBucket('default');

var couchbase = require('couchbase').Mock;
var db = new couchbase.Connection();

var Lab = require("lab");
Lab.experiment("CouchDB Tests", function() {
  // tests
  Lab.test("Set & Get a Value", function(done) {
    db.set('testdoc', {name:'test'}, function(err, result) {
      // if (err) throw err;

      db.get('testdoc', function(err, result) {
        // if (err) throw err;
        Lab.expect(result.value.name).to.equal('test');
        // console.log(result.value);
        done(); // done() callback is required to end the test.
      });
    });
  });
});
