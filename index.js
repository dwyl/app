var Hapi = require('hapi'),
    Joi  = require('joi');

var server = new Hapi.Server('0.0.0.0', 3000);

var T = {}; // Timer methods

T.getConfig = {
  handler: function(req, reply) {
    if (req.params.id) {
      if (quotes.length <= req.params.id) return reply('No timer found.').code(404);
      return reply(quotes[req.params.id]);
    }
    reply(quotes);
  }
};

T.getRandomConfig = {
  handler: function(req, reply) {
    var id = Math.floor(Math.random() * timers.length);
    reply(timers[id]);
  }
};

T.postConfig = {
  handler: function(req, reply) {
    var newQuote = { author: req.payload.author, text: req.payload.text };
    quotes.push(newQuote);
    reply(newQuote);
  }
, validate: {
    payload: {
      author: Joi.string().required()
    , text: Joi.string().required()
    }
  }
};

T.deleteConfig = {
  handler: function(req, reply) {
    if (quotes.length <= req.params.id) return reply('No quote found.').code(404);
    quotes.splice(req.params.id, 1);
    reply(true);
  }
};

var routes = [
  { path: '/timer/{id?}', method: 'GET', config: T.getConfig },
  { path: '/random', method: 'GET', config: T.getRandomConfig },
  { path: '/timer', method: 'POST', config: T.postConfig },
  { path: '/timer/{id}', method: 'DELETE', config: T.deleteConfig }
];


server.route([
  {
    method: 'GET',
    path: '/{yourname*}',
    config: {  // validate will ensure YOURNAME is valid before replying to your request
        validate: { params: { yourname: Joi.string().max(40).min(2).alphanum() } },
        handler: function (req,reply) {
            reply('Hello '+ req.params.yourname + '!');
        }
    },
  },
  {
    method: 'GET',
    path: '/hai/{hai*}',
    config: {  // validate will ensure YOURNAME is valid before replying to your request
        validate: { params: { hai: Joi.string().max(40).min(2).alphanum() } },
        handler: function (req,reply) {
            reply('Hello '+ req.params.hai + '!');
        }
    }
  }
]);

server.start(function() {
    // console.log('Now Visit: http://localhost:3000/YOURNAME');
});

module.exports = server;
