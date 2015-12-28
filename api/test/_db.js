// This "Test" Just checks we are able to connect to ElasticSearch
// without a database to store records this app is useless...
var ES    = require('esta');
var test  = require('tape');
var aguid = require('aguid');

var record =  {
  index: process.env.ES_INDEX,
  type: "timer",
  id: aguid(),
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
      t.equal(result._source.start, rec.start, "Record created: "+result._source.start);
      t.end();
    });
  });
});

test("UPDATE a record", function(t) {
  var record =  {
    index: process.env.ES_INDEX,
    type: "timer",
    id: aguid(),
    start: new Date().getTime()
  }
  var rec = {}; // make a copy of rec for later.
  for(var key in record) {
    if(record.hasOwnProperty(key)) {
      rec[key] = record[key];
    }
  }
  ES.CREATE(record, function(res) {
    rec.end = new Date().getTime();
    ES.UPDATE(rec, function(res) {
      ES.READ(rec, function(res) {
        t.equal(res._source.end, rec.end, "Record was updated: "+res._source.end);
        t.equal(res._version, 2, "Version: "+res._version);
        t.end();
      });
    });
  });
});

var session =  {
  index: process.env.ES_INDEX,
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
    ES.READ(rec2, function(result3) {
      t.equal(result3._source.start, rec2.start, "Record created: "+result3._source.start);
      t.end();
    });
  });
});

var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";


process.on('uncaughtException', function(err) {
  console.log('Database FAIL ... ' + err);
  console.log('Tip: Remember to start the Vagrant VM and Elasticsearch DB!')
});
