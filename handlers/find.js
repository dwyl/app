module.exports = {
  handler: function(req, reply) {
    var timers = [];
    if (req.params.id) {
      if (timers.length <= req.params.id) {
        return reply('No timer found.').code(404);
      } else {
        return reply(timers[req.params.id]);
      }

    }
    reply(timers);
  },
  // validate: require('../models/timer') // no validation in GET
}
