// var JWT   = require('jsonwebtoken');
var ES    = require('esta');
var aguid = require('aguid');
var Hoek  = require('hoek');

module.exports = function(req, reply) {
  // extract the person id from JWT
  var decoded = req.auth.credentials; //JWT.verify(req.headers.authorization, process.env.JWT_SECRET);
  var person = decoded.person;
  var created = new Date().toISOString();
  var id = aguid();
  var timer =  {
    index: "time",
    type: "timer",
    person: decoded.person,
    session: decoded.jti, // session id from JWT
    ct: created,
    id: id
  }

  for (var k in req.payload){
    timer[k] = req.payload[k]; // extract values from payload
  }
  if(!timer.st) { // client did not define the start time
    timer.st = created; // set it to the same as created
  } else {
    // allow the client to set the started time
  }

  ES.CREATE(timer, function(rec) {
    Hoek.merge(rec, timer); // http://git.io/Amv6
    reply(rec);
  })
}
