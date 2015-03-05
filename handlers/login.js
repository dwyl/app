var JWT    = require('jsonwebtoken');  // used to sign our content
var secret = 'NeverShareYourSecret'; // @todo use ENV var for this

// export single function (not object.handler!)
module.exports = function handler(req, reply) {
    // create JWT for auth header
    var token = JWT.sign(req.auth.credentials, secret);
    return reply('You Logged in!')
    .header("Authorization", token);
}
