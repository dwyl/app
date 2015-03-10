var ES = require('esta');
// var Boom = require('boom'); // error handling https://github.com/hapijs/boom

// bring your own validation function
var validateFunc = function (decoded, request, callback) {
  console.log(" - - -> handlers/auth_jwt_validate.js <- - -")
  console.log(" - - - decoded JWT token: - - -");
  console.log(decoded);

  var ua = decoded['user-agent'];   // see: https://github.com/ideaq/time/issues/62
  if(ua && ua !== request.headers['user-agent']) {
    console.log(" - - - FAIL - - - UA: " + ua)
    console.log(ua + " === " +request.headers['user-agent'])
    return callback(null, false); // session expired
  }
  if(!decoded.sid) {
    console.log(" - - - FAIL - - - sid: " + decoded.sid)
    return callback(null, false); // session expired
  }
  var session = {
    index : "time",
    type  : "session",
    id    : decoded.sid  // use SESSION ID as key for sessions
  }

  ES.READ(session, function(res){
    console.log(" - - - session: - - -");
    console.log(res);
    if(res.found && !res.end) {
      return callback(null, true); // session is valid
    }
    else {
      return callback(null, false); // session expired
    }
  });
  // console.log(" - - - request info: - - - - - -");
  // console.log(request.info);
  // console.log(" - - - user agent: " + request.headers['user-agent']);


    // do your checks to see if the person is valid
    // if (!people[decoded.id]) {
    //   return callback(null, false);
    // }
    // else {
    // }
};

module.exports = validateFunc
