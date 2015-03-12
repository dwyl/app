// anonymous people should be able to use the app
var JWT = require('../lib/auth_jwt_sign.js');
// export single function (not object.handler!)
module.exports = function handler(req, reply) {
  JWT(req, function(token, esres){
    return reply(esres).header("Authorization", token);
  }); // Asynchronous
}
