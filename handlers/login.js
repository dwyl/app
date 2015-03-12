var JWT = require('../lib/auth_jwt_sign.js');
// export single function (not object.handler!)
module.exports = function handler(req, reply) {
    // create JWT for auth header
    // console.log(' - - - LOGIN creds: ')
    // console.log(req.auth)
    // console.log(' - - - - - - - ')
    JWT(req, function(token, esres){
      return reply(esres).header("Authorization", token);
    }); // synchronous
}
