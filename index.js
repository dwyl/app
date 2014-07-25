var Hapi = require('hapi'),
    Joi  = require('joi');

var server = new Hapi.Server('0.0.0.0', 3000);

var T = {}; // Timer methods

// T.init(db);

T.get = {
  handler: function(req, reply) {
    var timers = [];
    if (req.params.id) {
      if (timers.length <= req.params.id) return reply('No timer found.').code(404);
      return reply(timers[req.params.id]);
    }
    reply(timers);
  }
};

T.postConfig = {
  handler: function(req, reply) {
    var newQuote = { author: req.payload.author, text: req.payload.text };
    quotes.push(newQuote);
    reply(newQuote);
  },
 validate: {
    payload: {
      author: Joi.string().required(),
      text: Joi.string().required()
    }
  }
};

var routes = [
  { path: '/timer/{id?}', method: 'GET', config: T.get },
  // { path: '/random', method: 'GET', config: T.getRandomConfig },
  { path: '/timer', method: 'POST', config: T.postConfig },
  // { path: '/timer/{id}', method: 'DELETE', config: T.deleteConfig }
];

server.route(routes);

server.start(function() {
    // console.log('Now Visit: http://localhost:3000/YOURNAME');
});

module.exports = server;
