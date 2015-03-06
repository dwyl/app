// import Boom for errors
var Boom   = require('boom'); // error handling https://github.com/hapijs/boom
// import the module we use to access the database
var Hoek   = require('hoek'); //
var ES     = require('esta');
// import the module we are using to encrypt passwords
var bcrypt = require('bcrypt');
// import the module we are using to create (GU)IDs
var aguid  = require('aguid');
var JWT    = require('jsonwebtoken');  // used to sign our content
var secret = 'NeverShareYourSecret';   // @todo use ENV var for this
// export single function (not object.handler!)
module.exports = function handler(req, reply) {

    if (!req.payload || !req.payload.email || !req.payload.password) {
      // check the request has a payload (if not send a 400 using Boom)
      return reply(Boom.badRequest('No payload'));
    }
    else {
      // lookup if the person with that email has *already* registered
      var record =  {
        index: "people",
        type: "person",
        id: aguid(req.payload.email),
        email: req.payload.email
      }

      //check db for for the person
      ES.READ(record, function(res) {
        if(res.found) {
          // return Boom 400 user already registered!
          return reply(Boom.badRequest('Email address already registered'));
        }
        else {// person has not registered
          //encrypt the password
          bcrypt.genSalt(12, function(err, salt) {
            bcrypt.hash(req.payload.password, salt, function(err, hash) {
              // console.log(hash); // our hashed password
              //add the encrypted password to the record
              record.password = hash;

              //register the new user
              ES.CREATE(record, function (res) {
                Hoek.assert(res.created, 'Person NOT Registered!');
                // console.log(' - - - - ES Res: ')
                // console.log(res);
                // console.log(' - - - - - - - - ')
                var token = JWT.sign({id:aguid(req.payload.email)}, secret); // synchronous
                return reply(res)
                  .header("Authorization", token);
              });
            });
          });

        }
      });
    }
}
