var ES = require('esta');

module.exports = function(req, reply) {
  var query =  {
    "index": "time",
    "type": "timer",
    "field": "person",
    "text": req.auth.credentials.person.toString() // using issuer as the person
  };
  ES.SEARCH(query, function(res) {
    if(res.hits.total > 0) {
      return reply(res.hits.hits);
    }
    else {
      return reply(res).code(404);
    }
  });
}
