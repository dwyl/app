var JWT   = require('jsonwebtoken');  // used to sign our content
var aguid = require('aguid');
var ES    = require('esta');
var dir   = __dirname.split('/')[__dirname.split('/').length-1];
var file  = dir + __filename.replace(__dirname, '') + " -> ";

module.exports = function sign(request, callback) {

  var toke = { jti:aguid() }; // v4 random UUID used as Session ID below

  if (request.payload && request.payload.email) {
    toke.iss = aguid(request.payload.email);
  } // see: http://self-issued.info/docs/draft-ietf-oauth-json-web-token.html#issDef
  else { // no email is set (means an anonymous person)
    toke.iss = "anonymous";
  } // this will need to be extended for other auth: http://git.io/pc1c

  var token = JWT.sign(toke, process.env.JWT_SECRET); // http://git.io/xPBn

  var session = {   // set up session record for inserting into ES
    index: "time",
    type:  "session",
    id  :  toke.jti,
    person: toke.iss,
    ua: request.headers['user-agent'],
    ct: new Date().toISOString()
  }

  ES.CREATE(session, function(esres) {
    return callback(token, esres);
  });
}
