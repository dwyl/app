var JWT      = require('../lib/auth_jwt_sign.js');
var transfer = require('../lib/transfer_anon_to_registered.js'); // see: http://git.io/vvf7k
var aguid    = require('aguid'); // used to derive the personid

module.exports = function handler(req, reply) {
    // transfer any records created before login: https://github.com/ideaq/time/issues/102
    if(!req.payload.email) {
      req.payload.email = req.auth.credentials.email;
    }
    req.auth = {
      credentials : {
        person: aguid(req.payload.email)
      }
    }
    return transfer(req, reply);
}
