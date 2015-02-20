var ES     = require('esta');
var errors = require('./errors');
var perma  = require('perma');

module.exports = {
  handler: function(req, reply) {
    // need some authentication / permissions logic here
    // if (req.params.id) {
    var record =  {
      index: "people",
      type: "person",
      id: perma(req.payload.email, 'full')
    }
    ES.READ(record, function(res) {
      // console.log(" - - - - - - - - ");
      // console.log(res);
      // console.log(" - - - - - - - - ");
      if(res.found) {
        return reply(res);
      } else {
        return reply(errors["login-unreg"]).code(errors["login-unreg"].status);
      }
    });
    // } else {
    //   return reply('No timer id supplied').code(404);
    // }
  },
  validate: require('../models/person')
}
