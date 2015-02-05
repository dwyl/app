var ES = require('esta');
var Lab = require("lab");
var lab = exports.lab = Lab.script();
var expect = require('code').expect;
var suite = lab.suite;
var test = lab.test;

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

suite("ES CRUD Tests", function() {
  // tests
  test("CONNECT TO ES", function(done) {
    ES.CONNECT(function(err, result) {
      // console.log('STATUS: '+result.status);
      expect(parseInt(result.status,10)).to.equal(200);
      done();
    });

  });

  test("CREATE & READ a record", function(done) {
    ES.CREATE(record, function(result) {

      ES.READ(rec, function(result) {
        // console.log(result);
        expect(result._source.start).to.equal(rec.start);
        done();
      });
    });
  });

  test("UPDATE a record", function(done) {
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
          expect(res._source.end).to.equal(rec.end);
          expect(res._version).to.equal(2);
          // console.log(result.value);
          done(); // done() callback is required to end the test.
        });
      });
    });
  });

});

process.on('uncaughtException', function(err) {
  // console.log('Something is not right there ... ' + err);
});
