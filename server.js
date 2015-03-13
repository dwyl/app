var Hapi    = require('hapi');
var Basic   = require('hapi-auth-basic');
var AuthJWT = require('hapi-auth-jwt2')
var Joi     = require('joi');
var ES      = require('esta');  // https://github.com/nelsonic/esta
var port    = process.env.PORT || 1337; // heroku define port or use 1337
var server  = new Hapi.Server();

server.connection({ port: port });

var routes = [ // move routes to separate file?
{ path: '/', method: 'GET',
  config: {
    auth: false,
    handler: require('./handlers/home')
  }
},
{ path: '/anonymous', method: 'GET',
  config: { auth: false, handler: require('./handlers/anonymous.js') } },
{ path: '/register', method: 'POST',
  config: { auth: false, validate: require('./models/person'),
  handler: require('./handlers/register.js') } },
{ path: '/login', method: 'POST',
  config: { auth: 'basic', handler: require('./handlers/login.js') } },
{ path: '/logout', method: 'POST',
  config: { auth: 'jwt', handler: require('./handlers/logout.js') } },
{ path: '/timer/{id}', method: 'GET',
  config: { auth: 'jwt', handler: require('./handlers/timer_find.js') } },
{ path: '/timer/new', method: 'POST',
  config: { validate: require('./models/timer'),
    auth: 'jwt', handler: require('./handlers/timer_start.js')
  }
}
  // { path: '/timer/{id}', method: 'DELETE', config: T.deleteConfig }
];
// [ {register: Basic}, {register: AuthJWT} ]
server.register([ {register: Basic}, {register: AuthJWT} ], function (err) {
  // if(err) {
  //   console.log(err);
  // }
  server.auth.strategy('basic', 'basic', {
    validateFunc: require('./lib/auth_basic_validate.js')
  });
  // required means this is the default auth for all routes
  // see: http://hapijs.com/tutorials/auth
  server.auth.strategy('jwt', 'jwt', 'required',  {
    key: process.env.JWT_SECRET,
    validateFunc: require('./lib/auth_jwt_validate.js')
  });
  server.route(routes);
});

server.start(function() {
    console.log('Now Visit: http://localhost:'+port);
});

module.exports = server;
