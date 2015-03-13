var JWT   = require('jsonwebtoken');  // used to sign our content
var Hoek  = require('hoek');
var aguid = require('aguid');
var ES    = require('esta');
var dir   = __dirname.split('/')[__dirname.split('/').length-1];
var file  = dir + __filename.replace(__dirname, '') + " -> ";

module.exports = function sign(request, callback) {
  var session = {}
  if(request.auth && request.auth.credentials){
    session = Hoek.clone(request.auth.credentials);
  }
  // include request.info details in the JWT so we can do rudimentary checks
  session['user-agent']    = request.headers['user-agent']; // client user-agent
  session['remoteAddress'] = request.info.remoteAddress;    // & IP Address
  if (!session.email && request.payload && request.payload.email) {
    session.person = aguid(request.payload.email);
  }
  else if (session.id) {
    session.person = session.id; // this is actually person._id ...
    delete session.email; // don't pass PII around
  }
  else { // no email is set (means an anonymous user)
    session.person = "anonymous";
  } // this will need to be extended for other auth: http://git.io/pc1c
  session.jti   = aguid();  // v4 random UUID
  var token = JWT.sign(session, process.env.JWT_SECRET);
  session.index = "time";
  session.type  = "session";
  session.id    = session.jti;  // use jti as SESSION ID as key for sessions
  session.ct    = new Date().toISOString();
  ES.CREATE(session, function(esres) {
    console.log(file + " Session Created: "+esres._id + " | "+esres.created +" - - - - esres: ");
    console.log(esres)
    console.log("   ") // blank line
    return callback(token, esres);
  });
}
