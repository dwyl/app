var Hapi    = require('hapi');
var AuthJWT = require('hapi-auth-jwt2')
var Basic   = require('hapi-auth-basic');
var Hoek    = require('hoek');
var Joi     = require('joi');
var ES      = require('esta');  // https://github.com/nelsonic/esta
var Path    = require('path');
var port    = process.env.PORT || 1337; // heroku define port or use 1337 1000
var server  = new Hapi.Server();

server.connection({ port: port });

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

// http://stackoverflow.com/questions/10750303
var os = require('os');
var interfaces = os.networkInterfaces();
var ip = [];
for (var k in interfaces) {
  for (var k2 in interfaces[k]) {
    var address = interfaces[k][k2];
    if (address.family === 'IPv4' && !address.internal) {
      ip.push(address.address);
    }
  }
}

server.start(function(){
  console.log('Now Visit: http://' + ip[0] + ':' +port);
});

module.exports = server;
