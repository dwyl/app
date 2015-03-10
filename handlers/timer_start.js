var ES    = require('esta');
var perma = require('perma');
var Hoek  = require('hoek'); //

module.exports = function(req, reply) {
    // extract the person id from JWT

    // fake it for now
    var person = Math.floor(Math.random() * (1000000));
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
