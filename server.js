require('env2')('.env'); // see: https://github.com/dwyl/time/issues/93
var Hapi   = require('hapi');
var Joi    = require('joi');
var server = new Hapi.Server();

server.connection({ port: process.env.PORT });

server.register([
  {register: require('hapi-auth-jwt2')}], function (err) {

  server.auth.strategy('jwt', 'jwt', 'required',  {
    key: process.env.JWT_SECRET,
    validateFunc: require('./lib/auth_jwt_validate.js')
  });

  server.route(require('./routes.js'));
});

server.start(function () {
  console.log('Now Visit: ' + require('./lib/lanip') + ':' + server.info.port);
});

module.exports = server;
