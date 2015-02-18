var ES    = require('esta');
var perma = require('perma');
var Hoek  = require('hoek'); //

module.exports = {
  handler: function(req, reply) {
    // extract the person id from JWT

    // fake it for now
    var person = Math.floor(Math.random() * (1000000));
    var created = new Date().toISOString();
    var timer =  {
      index: "time",
      type: "timer",
      person: person,
      ct: created,
      id: perma(person+created)
    }

    for (var k in req.payload){
      if (req.payload.hasOwnProperty(k)) {
        console.log("Key is " + k + ", value is " + req.payload[k]);
        timer[k] = req.payload[k]
      }
    }
    if(!timer.st) {
      timer.st = created;
    }
    ES.CREATE(timer, function(rec) {
      Hoek.merge(rec, timer); // http://git.io/Amv6
      reply(rec);
    })
  },
  validate: require('../models/timer')
}
