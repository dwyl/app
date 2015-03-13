// This "Test" Just checks we are able to connect to ElasticSearch
// if we do not have a database to store records this app is useless...
var ES = require('esta');
var test = require('tape');
var drop = require('./z_drop');
test("Teardown", function(t) {
  drop(function(res){
    t.equal(res.acknowledged, true, "All Records Deleted");
    t.end();
  }).end();
});


var record =  {
  index: "time",
  type: "timer",
  id: Math.floor(Math.random() * (1000000)),
  start: new Date().toISOString()
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

var aguid = require('aguid');

var session =  {
  index: "time",
  type: "session",
  id: aguid(),
  start: new Date().toISOString(),
  ct: new Date().toISOString(),
  person: "anonymous"
}

var rec2 = {}; // make a copy of rec for later.
for(var key in session) {
  if(session.hasOwnProperty(key)) {
    rec2[key] = session[key];
  }
}

test("CREATE & READ a SESSION record", function(t) {
  ES.CREATE(session, function(result2) {
    console.log(result2);
    ES.READ(rec2, function(result3) {
      console.log("Session Created:");
      console.log(result3);
      t.equal(result3._source.start, rec2.start, "Record created: "+result3._source.start);
      t.end();
    });
  });
});



process.on('uncaughtException', function(err) {
  console.log('Database FAIL ... ' + err);
  console.log('Tip: Remember to start the Vagrant VM and Elasticsearch DB!')
});
