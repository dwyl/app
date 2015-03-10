var JWT   = require('jsonwebtoken');  // used to sign our content
var Hoek  = require('hoek');
var aguid = require('aguid');

module.exports = function sign(request) {
  var obj = {}
  if(request.auth && request.auth.credentials){
    obj = Hoek.clone(request.auth.credentials);
  } else {
    // do nothing ... istanbul!
  }
  // include request.info details in the JWT so we can do rudimentary checks
  obj['user-agent']    = request.headers['user-agent']; // client user-agent
  obj['remoteAddress'] = request.info.remoteAddress;    // & IP Address
  if (!obj.email && request.payload && request.payload.email) {
    obj.id = aguid(request.payload.email);
  }
  return JWT.sign(obj, process.env.JWT_SECRET);
}
