var ES    = require('esta');
var Boom  = require('boom'); // error handling https://github.com/hapijs/boom
var dir   = __dirname.split('/')[__dirname.split('/').length-1];
var file  = dir + __filename.replace(__dirname, '') + " -> ";
// bring your own validation function
var validateFunc = function (decoded, request, callback) {
  // console.log(file + "decoded JWT token for REQUEST: "+ request.method + " "+request.url.path);
  // console.log(decoded);
  // console.log(" ");
  var session = {
    index : "time",
    type  : "session",
    id    : decoded.jti  // use SESSION ID as key for sessions
  } // jti? wtf? >> http://self-issued.info/docs/draft-ietf-oauth-json-web-token.html#jtiDef
  // console.log(file + "Attempt to READ Session: " +session.id)
  ES.READ(session, function(res){
    // console.log(file + "ES.READ(session -> res")
    // console.log(res)
    // console.log(" ");
    // console.log(file + "Session found: "+res.found);
    // console.log(file + "Session ended: "+res._source.ended);
    if(res.found && !res._source.ended) {
      return callback(null, true); // session is valid
    }
    else {
      // console.log(file + "Invalid Session");
      return callback(null, false); // session expired
    }
  });
};

module.exports = validateFunc
