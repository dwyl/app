module.exports = {
  handler: function(req, reply) {
    for (var k in req.payload){
      if (req.payload.hasOwnProperty(k)) {
        console.log("Key is " + k + ", value is" + req.payload[k]);
      }
    }
    var timer = req.payload;
    reply(timer);
  },
  validate: require('../models/timer')
}
