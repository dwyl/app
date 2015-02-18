var ES = require('esta');

module.exports = {
  handler: function(req, reply) {
    // need some authentication / permissions logic here
    if (req.params.id) {
      var record =  {
        index: "time",
        type: "timer",
        id: req.params.id
      }
      ES.READ(record, function(res) {
        // console.log(" - - - - - - - - ");
        // console.log(res);
        // console.log(" - - - - - - - - ");
        if(res.found) {
          return reply(res);
        } else {
          return reply('No timer found.').code(404);
        }
      });
    } else {
      return reply('No timer id supplied').code(404);
    }
  },
  // validate: require('../models/timer') // no validation in GET
}
