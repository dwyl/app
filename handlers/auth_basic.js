var ES     = require('esta');
var Bcrypt = require('bcrypt');
var aguid  = require('aguid'); // https://github.com/ideaq/aguid

module.exports = function validateFunc (email, password, callback) {
  var record =  {
    index: "people",
    type: "person",
    id: aguid(email)
  }

  ES.READ(record, function(res) {
    if(res.found) { // compare to bcrypt hash on file
      Bcrypt.compare(password, res.password, function (err, isValid) {

        callback(err, isValid, { id: user.id, name: user.name });
      });
    } else {
      // person has not registered
      callback(null, false);
    }
  });
};
