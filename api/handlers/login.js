var JWT      = require('../lib/auth_jwt_sign.js');
var find_all = require('./timer_find_all'); // see: http://git.io/vvf7k
var aguid    = require('aguid'); // used to derive the personid

module.exports = function handler(req, reply) {
  JWT(req, function(token, esres){
    // login now returns all records as well!  see: http://git.io/vvf7k
    req.auth = {
      credentials : {
        person: aguid(req.payload.email)
      }
    }
    req.headers.authorization = token; // pass the token along
    return find_all(req, reply, 200);
  }); // async
}
