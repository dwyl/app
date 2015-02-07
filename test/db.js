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
  ES.CONNECT(function(err, result) {
    if(err){
      console.error(err);
    }
    // console.log('STATUS: '+result.status);
    if(result.status !== 200) {
      console.error('')
    }
    t.equal(parseInt(result.status,10), 200);
    t.end();
  });

});

test("CREATE & READ a record", function(t) {
  ES.CREATE(record, function(result) {

    ES.READ(rec, function(result) {
      // console.log(result);
      t.equal(result._source.start, rec.start);
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
        t.equal(res._source.end, rec.end);
        t.equal(res._version, 2);
        // console.log(result.value);
        t.end(); // done() callback is required to end the test.
      });
    });
  });
});

process.on('uncaughtException', function(err) {
  console.log('Something is not right there ... ' + err);
});
