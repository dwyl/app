var JWT   = require('jsonwebtoken');  // used to sign our content
var Hoek  = require('hoek');
var aguid = require('aguid');
var ES    = require('esta');
var dir   = __dirname.split('/')[__dirname.split('/').length-1];
var file  = dir + __filename.replace(__dirname, '') + " -> ";

function createSession(obj) {

  obj.index = "time";
  obj.type  = "session";
  obj.id    = obj.jti;  // use jti as SESSION ID as key for sessions
  obj.ct    = new Date().toISOString();
  return ES.CREATE(obj, function(res) {
    console.log(file + " Session Created: "+res._id + " | "+res.created);
  });
}

module.exports = function sign(request) {
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
  obj.jti = aguid();  // v4 random UUID
  createSession(obj); // register a new session
  return JWT.sign(obj, process.env.JWT_SECRET);
}
