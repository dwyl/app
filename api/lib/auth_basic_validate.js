var ES     = require('esta');
var Bcrypt = require('bcrypt');
var aguid  = require('aguid'); // https://github.com/ideaq/aguid

module.exports = function validate (email, password, callback) {

  var person =  {
    index: process.env.ES_INDEX,
    type: "person",
    id: aguid(email)
  }

  ES.READ(person, function(res) {
    console.log(' auth_basic_validate.js - - - - - - - - - - - - - ES.READ(person)')
    console.log(res);
    console.log(' - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ')
    if(res.found) { // compare to bcrypt hash on file
      Bcrypt.compare(password, res._source.password, function (err, isValid) {
        return callback(err, isValid, { id: res._id, email: res._source.email });
      });
    } else {
      return callback(null, false); // person has not registered
    }
  });
};
