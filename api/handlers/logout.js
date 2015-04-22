var ES    = require('esta');
var redisClient = require('../lib/redis_connection');

module.exports = function logout(req, reply) {
  // console.log(req.auth)
  // console.log(' - - - - - - - - - - - - - - - \n\n')
  var session = {
    index : process.env.ES_INDEX,
    type  : "session",
    id    : req.auth.credentials.jti,
    ended : new Date().toISOString()
  }

  ES.UPDATE(session, function(res){
    // update es session for kibana but use redis as primary ses store!
  });
  redisClient.get(req.auth.credentials.jti, function (err, redisreply) {
    // console.log('REDIS SESSION is ' +redisreply.toString());
    var ses = JSON.parse(redisreply);
    ses.ended = session.ended;
    redisClient.set(req.auth.credentials.jti, JSON.stringify(ses));
    return reply(ses);
  });
}
