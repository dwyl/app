var ES     = require('esta');
var Bcrypt = require('bcrypt');
var aguid  = require('aguid'); // https://github.com/ideaq/aguid

module.exports = function validate (email, password, callback) {

  var record =  {
    index: "time",
    type: "person",
    id: aguid(email)
  }

  ES.READ(record, function(res) {
    // console.log(" - - - - - - - - - - - - ");
    // console.dir(res); // show boom result from hapi-auth-basic
    // console.log(" - - - - - - - - - - - - ");
    if(res.found) { // compare to bcrypt hash on file
      Bcrypt.compare(password, res._source.password, function (err, isValid) {
        callback(err, isValid, { id: res._id, email: res._source.email });
      });
    } else {
      // person has not registered
      callback(null, false);
    }
  });
};