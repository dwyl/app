var JWT   = require('jsonwebtoken');  // used to sign our content
var Hoek  = require('hoek');
var aguid = require('aguid');
var ES    = require('esta');


function createSession(obj) {
  obj.index = "time";
  obj.type  = "session";
  obj.id    = obj.sid;  // use SESSION ID as key for sessions
  return ES.CREATE(obj, function(res) {
    console.log("Session Created: "+res._id + " | " +obj.person);
  });
}

module.exports = function sign(request) {
  var obj = {}
  if(request.auth && request.auth.credentials){
    obj = Hoek.clone(request.auth.credentials);
  }
  // } else {
  //   // do nothing ... istanbul!
  // }

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
  obj.sid = aguid();  // v4 random UUID
  createSession(obj); // register a new session
  return JWT.sign(obj, process.env.JWT_SECRET);
}
