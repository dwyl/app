var Boom   = require('boom'); // error handling https://github.com/hapijs/boom
var Hoek   = require('hoek');
var ES     = require('esta');
var bcrypt = require('bcrypt'); // import the module we are using to encrypt passwords
var aguid  = require('aguid'); // import the module we are using to create (GU)IDs
var JWT    = require('../lib/auth_jwt_sign.js'); // used to sign our content
var transfer = require('../lib/transfer_anon_to_registered.js');

module.exports = function handler(req, reply) {
  var personid = aguid(req.payload.email)
  var person =  {
    index: "people",
    type: "person",
    id: personid,
    email: req.payload.email
  }

  ES.READ(person, function(res) {
    if(res.found) { // return Boom 400 user already registered!
      return reply(Boom.badRequest('Email address already registered'));
    }
    else {// person with that email has yet not registered
      bcrypt.genSalt(12, function(err, salt) { //encrypt the password
        bcrypt.hash(req.payload.password, salt, function(err, hash) {

          person.password = hash;

          ES.CREATE(person, function (res) {

            Hoek.assert(res.created, 'Person NOT Registered!'); // only if DB fails!
            // transfer any anonymous timers & session to the person
            if(req.headers.authorization){
              // console.log("AUTH TOKEN:"+req.headers.authorization);
              return transfer(req, reply, personid);
            }
            else {
              JWT(req, function(token, esres){
                return reply(esres).header("Authorization", token);
              }); // Asynchronous
            }

          }); // end ES.CREATE
        }); // end bcrypt.hash
      }); // end bcrypt.genSalt
    }
  });
}
