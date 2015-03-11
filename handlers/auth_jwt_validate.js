var ES = require('esta');
// var Boom = require('boom'); // error handling https://github.com/hapijs/boom

// bring your own validation function
var validateFunc = function (decoded, request, callback) {
  console.log(" - - - handlers/auth_jwt_validate.js > decoded JWT token: - - -");
  console.log(decoded);
  // console.log(" - - - request info: - - - - - -");
  // console.log(request.info);

  // var ua = decoded['user-agent'];   // see: https://github.com/ideaq/time/issues/62
  // if(ua && ua !== request.headers['user-agent']) {
  //   console.log(" - - - FAIL - - - UA: " + ua)
  //   console.log(ua + " === " +request.headers['user-agent'])
  //   return callback(null, false); // session expired
  // }
  if(!decoded.jti) {
    console.log(" - - - FAIL - - - sid: " + decoded.sid)
    return callback(null, false); // session expired
  }
  var session = {
    index : "time",
    type  : "session",
    id    : decoded.jti  // use SESSION ID as key for sessions
  } // jti? wtf? >> http://self-issued.info/docs/draft-ietf-oauth-json-web-token.html#jtiDef
  console.log(" > > > Attempt to READ: " +session.id)
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
};

module.exports = validateFunc
