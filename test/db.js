var couchbase = require('couchbase').Mock;
var db = new couchbase.Connection();
var d = require('../lib/time');

// console.log(d);

var Lab = require("lab");
Lab.experiment("CouchDB Tests", function() {
  // tests
  Lab.test("Set & Get a record", function(done) {
    db.set('testdoc', {name:'test'}, function(err, result) {

      db.get('testdoc', function(err, result) {

        Lab.expect(result.value.name).to.equal('test');
        // console.log(result.value);
        done();
      });
    });
  });

  Lab.test("Update a record", function(done) {
    db.set('testdoc', {name:'initial'}, function(err, result) {
      // if (err) throw err;
      db.set('testdoc', {name: 'updated'}, function(err, result) {
        db.get('testdoc', function(err, result) {
          // if (err) throw err;
          Lab.expect(result.value.name).to.equal('updated');
          // console.log(result.value);
          done(); // done() callback is required to end the test.
        });
      });
    });
  });

});
