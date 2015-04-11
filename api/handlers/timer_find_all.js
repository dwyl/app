var ES = require('esta');

module.exports = function timer_find_all(req, reply, statusCode) {
  var token = req.headers.authorization;
  if(!statusCode || typeof statusCode === 'undefined') {
    statusCode = 404;
  }
  var query =  {
    "index": "time",
    "type": "timer",
    "field": "person",
    "text": req.auth.credentials.person.toString() // using issuer as the person
  };
  ES.SEARCH(query, function(res) {
    if(res.hits.total > 0) {
      return reply({ timers: res.hits.hits }).header("Authorization", token);
    }
    else {
      return reply(res).code(statusCode);
    }
  });
}
