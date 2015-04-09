var ES    = require('esta');
var aguid = require('aguid');
var Hoek  = require('hoek');
var JWT  = require('jsonwebtoken'); // https://github.com/docdis/learn-json-web-tokens

/**
 * The purpose of this method is to transfer the session
 * and all existing timers from an anonymous person to their
 * registered account on the system.
 * so... first thing is we lookup their session id from the JWT
 */

module.exports = function(req, reply, personid) {
  JWT.verify(req.headers.authorization, process.env.JWT_SECRET, function(err, decoded) {
    console.log(" - - - - Transfer - - - - ")
    // console.log(req.auth.credentials);
    console.log(personid);
    // console.log(decoded);
    var session = {
      index : "time",
      type  : "session",
      id    : decoded.jti,
      person: personid
    }
    var copy = {
      index : "time",
      type  : "session",
      id    : decoded.jti,
      person: personid
    }
    ES.READ(session, function(ses) {
      console.log("Anon SESSION :",ses);
      var session = ses._source;
      session.index = "time";
      session.type = "session";
      session.person = personid;
      session.id = decoded.jti;

      // set the person.id of Existing Session
      ES.UPDATE(session, function(res2) {
        ES.READ(copy, function(res4){
          console.log("SESSION Updated: ", res4);
          // lookup all the records that were created with the anon session
          var query =  {
            "index": "time",
            "type": "timer",
            "field": "session",
            "text": decoded.jti
          };

          // console.log(" - - - - - - - - - - SEARCH QUERY: ");
          // console.log(query)
          // console.log(" - - - - - - - - - - ");
          ES.SEARCH(query, function(res) {
            console.log(res.hits.total);
            console.log(" - - - - - - - - - - hits: ");
            console.log(res.hits.hits[0]);
            if(res.hits.total > 0) {
              return reply(res);
            }
            else {

            }
          }); // END SEARCH
        })
      }); // END session UPDATE

    });

  });
  // var decoded = req.auth.credentials;

  // var timer =  {
  //   index:   "time",
  //   type:    "timer",
  //   id: req.payload.id
  // }
  // // FIRST lookup the timer to see if it exists
  // ES.READ(timer, function(esres) {
  //   // console.log(esres);
  //   // console.log(" - - - - - - - - - - - - ");
  //   if(esres.found){
  //     for (var k in esres._source) {
  //       timer[k] = esres._source[k]; // extract values from existing record
  //     }
  //     // UPDATE the relevant fields:
  //     for (var j in req.payload) {
  //       timer[j] = req.payload[j]; // extract values from payload
  //     }
  //   }
  //   else { // create a NEW Timer Record:
  //     timer.person  = decoded.person;
  //     timer.session = decoded.jti; // session id from JWT
  //     timer.ct      = new Date().toISOString();
  //     //a timer should ALWAYS have a start time
  //     if(!req.payload.start) { // client did not define the start time
  //       timer.start = timer.ct; // set it to the same as created
  //     } else {
  //       // allow the client to set (and UPDATE!) the started time
  //     }
  //     // UPDATE the relevant fields:
  //     for (var l in req.payload) {
  //       timer[l] = req.payload[l]; // extract values from payload
  //     }
  //     // BUT don't allow setting id for *NEW* Timers
  //     timer.id = aguid();
  //   }
  //
  //
  //   ES.UPDATE(timer, function(record) {
  //     Hoek.merge(record, timer); // http://git.io/Amv6
  //     record.id = record._id;
  //     delete record._index;
  //     delete record._type;
  //     delete record._version;
  //     delete record.person;
  //     delete record._id
  //     reply(record);
  //   })
  // });
  // // delete the excess fields so we don't bloat the record:
  // delete req.payload._index;
  // delete req.payload._type;
  // delete req.payload._version;
}
