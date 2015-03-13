var ES    = require('esta');

module.exports = function logout(req, reply) {
  var session = {
    index : "time",
    type  : "session",
    id    : req.auth.credentials.jti,
    ended : new Date().toISOString()
  }
  ES.UPDATE(session, function(res){
    return reply(res);
  });
}
