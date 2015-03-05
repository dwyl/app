console.log("hello from login.js");
// export single function (not object.handler!)
module.exports = function handler(req, reply) {
    // create JWT for auth header
    // console.log("Im inside login.js module");
    // console.log(" - - - - - - - - - - - - ");
    // console.log(req);
    // console.log(" - - - - - - - - - - - - ");
    return reply('You Logged in!');
}
