var ES     = require('esta');
var errors = require('./errors');
var perma  = require('perma');

// export single function (not object.handler! )
module.exports = function handler(req, reply) {
    // // need some authentication / permissions logic here
    // // if (req.params.id) {
    // var record =  {
    //   index: "people",
    //   type: "person",
    //   id: perma(req.payload.email, 17) // exceptionally low collision probability
    // }
    // ES.READ(record, function(res) {
    //   // console.log(" - - - - - - - - ");
    //   // console.log(res);
    //   // console.log(" - - - - - - - - ");
    //   if(res.found) {
    //     return reply(res);
    //   } else {
    //     return reply(errors["login-unreg"]).code(errors["login-unreg"].status);
    //   }
    // });
    // } else {
    //   return reply('No timer id supplied').code(404);
    // }
    return reply('it worked!');
}
