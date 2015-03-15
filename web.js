var Hapi    = require('hapi');
var Basic   = require('hapi-auth-basic');
var AuthJWT = require('hapi-auth-jwt2')
var Joi     = require('joi');
var ES      = require('esta');  // https://github.com/nelsonic/esta
var port    = process.env.PORT || 1337; // heroku define port or use 1337
var server  = new Hapi.Server();

server.connection({ port: port });

var routes = require('./api/routes.js');

server.register([ {register: Basic}, {register: AuthJWT} ], function (err) {

  server.auth.strategy('basic', 'basic', {
    validateFunc: require('./api/lib/auth_basic_validate.js')
  });

  server.auth.strategy('jwt', 'jwt', 'required',  {
    key: process.env.JWT_SECRET,
    validateFunc: require('./api/lib/auth_jwt_validate.js')
  });

  server.route(routes);

});

server.start(function(){
  console.log('Now Visit: http://localhost:'+port);
});


module.exports = server;
