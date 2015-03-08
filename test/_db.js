// This "Test" Just checks we are able to connect to ElasticSearch
var ES = require('esta');
var test = require('tape');

var record =  {
  index: "time",
  type: "timer",
  id: Math.floor(Math.random() * (1000000)),
  start: new Date().getTime()
}

var rec = {}; // make a copy of rec for later.
for(var key in record) {
  if(record.hasOwnProperty(key)) {
    rec[key] = record[key];
  }
}

test("CONNECT to ElasticSearch", function(t) {
  ES.CONNECT(function(result) {
    t.equal(parseInt(result.status, 10), 200, "Status 200");
    t.end();
  });

});

test("CREATE & READ a record", function(t) {
  ES.CREATE(record, function(result) {

    ES.READ(rec, function(result) {
      // console.log(result);
      t.equal(result._source.start, rec.start, "Record created: "+result._source.start);
      t.end();
    });
  });
});

test("UPDATE a record", function(t) {
  var record =  {
    index: "time",
    type: "timer",
    id: Math.floor(Math.random() * (1000000)),
    start: new Date().getTime()
  }
  var rec = {}; // make a copy of rec for later.
  for(var key in record) {
    if(record.hasOwnProperty(key)) {
      rec[key] = record[key];
    }
  }
  ES.CREATE(record, function(res) {
    // if (err) throw err;
    rec.end = new Date().getTime();
    ES.UPDATE(rec, function(res) {
      // console.log(rec);
      ES.READ(rec, function(res) {
        // console.log(res);
        t.equal(res._source.end, rec.end, "Record was updated: "+res._source.end);
        t.equal(res._version, 2, "Version: "+res._version);
        // console.log(result.value);
        t.end(); // done() callback is required to end the test.
      });
    });
  });
});

process.on('uncaughtException', function(err) {
  console.log('Database FAIL ... ' + err);
  console.log('Tip: Remember to start the Vagrant VM and Elasticsearch DB!')
});
