var JWT   = require('jsonwebtoken');
var ES    = require('esta');
var perma = require('perma');
var Hoek  = require('hoek');

module.exports = function(req, reply) {
    // extract the person id from JWT
    var decoded = JWT.verify(req.headers.authorization, process.env.JWT_SECRET);
    // fake it for now
    var person = decoded.person;
    var created = new Date().toISOString();
    var id = perma(person+created);
    var timer =  {
      index: "time",
      type: "timer",
      person: person,
      ct: created,
      id: id
    }

    for (var k in req.payload){
      // if (req.payload.hasOwnProperty(k)) {
        // console.log("Key is " + k + ", value is " + req.payload[k]);
        timer[k] = req.payload[k];
      // }
    }
    if(!timer.st) {
      timer.st = created;
    } else {
      // allow the client to set the started
    }
    ES.CREATE(timer, function(rec) {
      Hoek.merge(rec, timer); // http://git.io/Amv6
      reply(rec);
    })
}
