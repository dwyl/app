var JWT   = require('jsonwebtoken');  // used to sign our content
var Hoek  = require('hoek');
var aguid = require('aguid');
var ES    = require('esta');
var dir   = __dirname.split('/')[__dirname.split('/').length-1];
var file  = dir + __filename.replace(__dirname, '') + " -> ";

module.exports = function sign(request, callback) {
  var toke = {}
  // if(request.auth && request.auth.credentials){
  //   session.iss = request.auth.credentials.id; // id of the person who authenticated
  // }
  // include request.info details in the JWT so we can do rudimentary checks
  // session['user-agent']    = request.headers['user-agent']; // client user-agent
  // session['remoteAddress'] = request.info.remoteAddress;    // & IP Address
  if (request.payload && request.payload.email) {
    toke.iss = aguid(request.payload.email);
  } // see: http://self-issued.info/docs/draft-ietf-oauth-json-web-token.html#issDef
  else { // no email is set (means an anonymous user)
    toke.iss = "anonymous";
  } // this will need to be extended for other auth: http://git.io/pc1c
  toke.jti   = aguid();  // v4 random UUID used as Session ID below (makes token unique!)
  // console.log(file +"TOKEN Object we want to sign:");
  // console.log(toke);
  // console.log(" ") // blank line
  var token = JWT.sign(toke, process.env.JWT_SECRET);
  // console.log(token);
  // var decoded = JWT.verify(token, process.env.JWT_SECRET);
  // console.log(" ")
  // console.log(file + "DECODED token: ")
  // console.log(decoded);

  // set up session record for inserting into ES
  var session = {
    index: "time",
    type:  "session",
    id  :  toke.jti,
    person: toke.iss,
    ct: new Date().toISOString()
  }
  // console.log(file + " Session RECORD to insert into ES:")
  // console.log(session);

  ES.CREATE(session, function(esres) {
    // console.log(file + " Session Created: "+esres._id + " | "+esres.created +" - - - - esres: ");
    // console.log(esres)
    // console.log("   ") // blank line
    return callback(token, esres);
  });
}
