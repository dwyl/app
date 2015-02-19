module.exports = {
  handler: function(req, reply) {
    // console.log(req);
    // need to define exactly what the API should return on home page.
    // e.g: please register at timerzzz.com
    reply('Welcome to Timer Land!');
  }
}
