// var couchbase = require('couchbase').Mock;
// var db = new couchbase.Connection();

var couchbase = require('couchbase');
var cluster = new couchbase.Cluster();
var db = cluster.openBucket('default');

db.set('testdoc', {name:'Frank'}, function(err, result) {
  if (err) throw err;

  db.get('testdoc', function(err, result) {
    if (err) throw err;

    console.log(result.value);
    // {name: Frank}
  });
});



console.log('hai CouchBase');
