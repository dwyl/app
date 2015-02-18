var Hapi = require('hapi');
var Joi  = require('joi');
var ES   = require('esta');
var port = process.env.PORT || 1337; // heroku define port or use 1337
var server = new Hapi.Server();
server.connection({ port: port });

var routes = [
{ path: '/home', method: 'GET',
  config: require('./handlers/home')  },
{ path: '/timer/{id?}', method: 'GET',
  config: require('./handlers/find_timer.js')  },
{ path: '/timer/new', method: 'POST',
  config: require('./handlers/start_timer.js') }
  // { path: '/timer/{id}', method: 'DELETE', config: T.deleteConfig }
];

server.route(routes);

server.start(function() {
    console.log('Now Visit: http://localhost:'+port);
});

module.exports = server;
