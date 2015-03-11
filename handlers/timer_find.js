var ES = require('esta');
var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";

module.exports = function(req, reply) {
    // need some authentication / permissions logic here
    // if (req.params.id) {
      var record =  {
        index: "time",
        type: "timer",
        id: req.params.id
      }
      // console.log(file + "Record to lookup: - - - - - - - - - - - - - - - - - - - - - - - -")
      // console.log(record)
      ES.READ(record, function(res) {
        // console.log(" - - - - - - - - ");
        // console.log(res);
        // console.log(" - - - - - - - - ");
        if(res.found) {
          return reply(res);
        } else {
          return reply(res).code(404);
        }
      });
    // } else {
    //   return reply('No timer id supplied').code(404);
    // }
  // validate: require('../models/timer') // no validation in GET
}
