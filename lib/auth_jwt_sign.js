var JWT   = require('jsonwebtoken');  // used to sign our content
var Hoek  = require('hoek');
var aguid = require('aguid');
var ES    = require('esta');
var dir   = __dirname.split('/')[__dirname.split('/').length-1];
var file  = dir + __filename.replace(__dirname, '') + " -> ";

//
function createSession(session, token, callback) {
  session.index = "time";
  session.type  = "session";
  session.id    = session.jti;  // use jti as SESSION ID as key for sessions
  session.ct    = new Date().toISOString();
  ES.CREATE(session, function(esres) {
    console.log(file + " Session Created: "+esres._id + " | "+esres.created);
    return callback(token, esres);
  });
}

module.exports = function sign(request, callback) {
  var obj = {}
  if(request.auth && request.auth.credentials){
    obj = Hoek.clone(request.auth.credentials);
  }

  // include request.info details in the JWT so we can do rudimentary checks
  obj['user-agent']    = request.headers['user-agent']; // client user-agent
  obj['remoteAddress'] = request.info.remoteAddress;    // & IP Address
  if (!obj.email && request.payload && request.payload.email) {
    obj.person = aguid(request.payload.email);
  }
  else if (obj.id) {
    obj.person = obj.id;
    delete obj.email; // don't pass PII around
  }
  else { // no email is set (means an anonymous user)
    obj.person = "anonymous";
  } // this will need to be extended for other auth: http://git.io/pc1c
  obj.jti   = aguid();  // v4 random UUID
  var token = JWT.sign(obj, process.env.JWT_SECRET);
  return createSession(obj, token, callback); // register a new session
}
