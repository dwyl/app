// var ES = require('esta');
var redisClient = require('./redis_connection');
// console.log(' - - - - - - - - - REDIS CONNECTION');
// console.log(redisClient.get.toString())
// console.log(' - - - - - - - - - - - - - - - - - - - - - -')

var validateFunc = function (decoded, request, callback) {

  var session = {
    index : process.env.ES_INDEX,
    type  : "session",
    id    : decoded.jti  // use SESSION ID as key for sessions
  } // jti? >> http://self-issued.info/docs/draft-ietf-oauth-json-web-token.html#jtiDef
  console.log(' - - - - - - - - - DECODED');
  console.log(decoded);

  // redisClient.set('redis', 'working');
  // redisClient.get('redis', function (err, reply) {
  //   console.log(' - - - - - - - - - REDIS ERROR');
  //   console.log(err);
  //   console.log(' - - - - - - - - - REDIS REPLY');
  //   console.log(reply);
  // });

  redisClient.get(decoded.jti, function (err, reply) {
    console.log(' - - - - - - - - - REDIS ERROR');
    console.log(err);
    console.log(' - - - - - - - - - REDIS REPLY');
    console.log(reply);
    console.log(' - - - - - - - - - - - - - - - - - - - - - - - - - - - - - ');

    // console.log(reply.toString(), ' RedisCLOUD is ' +reply.toString());
    var session = JSON.parse(reply);
    redisClient.end();
    if(!session.ended) {
      return callback(null, true); // session is valid
    }
    else {
      return callback(null, false); // session expired
    }
  });

  // ES.READ(session, function(res){
  //   if(res.found && !res._source.ended) {
  //     return callback(null, true); // session is valid
  //   }
  //   else {
  //     return callback(null, false); // session expired
  //   }
  // });
};

module.exports = validateFunc;
