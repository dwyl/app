var ES    = require('esta');
var JWT   = require('jsonwebtoken');
var dir   = __dirname.split('/')[__dirname.split('/').length-1];
var file  = dir + __filename.replace(__dirname, '') + " -> ";
// export single function (not object.handler!)
module.exports = function logout(req, reply) {
    // unless we pass the decoded token through to this handler we need to re-verify
    var decoded = JWT.verify(req.headers.authorization, process.env.JWT_SECRET);

    var session = {
      index : "time",
      type  : "session",
      id    : decoded.jti,  // use SESSION ID as key for sessions
      ended : new Date().toISOString()
    }

    console.log(file + "Attempt to UPDATE Session: " +session.id)
    ES.UPDATE(session, function(res){
      console.log(file + "session: - - -");
      console.log(res);
      // if(res.found) {
      return reply(res);
    });
}
