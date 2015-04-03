var Hapi    = require('hapi');
var AuthJWT = require('hapi-auth-jwt2')
var Basic   = require('hapi-auth-basic');
var Hoek    = require('hoek');
var Joi     = require('joi');
var ES      = require('esta');  // https://github.com/nelsonic/esta
var Path    = require('path');
var port    = process.env.PORT || 1337; // heroku define port or use 1337 1000
var server  = new Hapi.Server();
var ip      = require('./api/lib/lanip');
console.log(">>>>>> IP: "+ip)
server.connection({ host : ip, port: port, routes: { cors: true } });

server.register([ {register: Basic}, {register: AuthJWT} ], function (err) {

  server.auth.strategy('basic', 'basic', {
    validateFunc: require('./api/lib/auth_basic_validate.js')
  });

  server.auth.strategy('jwt', 'jwt', 'required',  {
    key: process.env.JWT_SECRET,
    validateFunc: require('./api/lib/auth_jwt_validate.js')
  });

  server.views({
    engines: {
        html: require('handlebars')
    },
    relativeTo: __dirname,
    path: Path.join(__dirname, 'front/views'),
    layoutPath: './views/layout',
  });
  var api    = require('./api/routes.js');
  var front  = require('./front/routes.js');
  var routes = Hoek.merge(api, front);
  server.route(routes);

});

server.start(function(){
  console.log('Now Visit: http://' + ip + ':' +port);
});

module.exports = server;
