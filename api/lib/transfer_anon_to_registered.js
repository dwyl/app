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
      // console.log("Anon SESSION :",ses);
      var session = ses._source;
      session.index = "time";
      session.type = "session";
      session.person = personid;
      session.id = decoded.jti;

      // set the person.id of Existing Session
      ES.UPDATE(session, function(res2) {
        ES.READ(copy, function(res4){
          // console.log("SESSION Updated: ", res4);
          // lookup all the records that were created with the anon session
          var query =  {
            "index": "time",
            "type": "timer",
            "field": "session",
            "text": decoded.jti
          };

          ES.SEARCH(query, function(res) {
            // console.log(res.hits.total);
            // console.log(" - - - - - - - - - - hits: ");
            res.hits.hits.forEach(function(hit){
              // console.log(hit);
              var timer = hit._source;
              timer.id = hit._id;
              timer.index = hit._index;
              timer.type = hit._type;
              timer.person = personid; // the whole point of this!
              ES.UPDATE(timer, function(res){
                // console.log("VERSION:",res._version);
              })
            })
            return reply(res);
          }); // END SEARCH
        })
      }); // END session UPDATE
    });
  });
}
