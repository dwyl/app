var path = require('path');
var cssdir = path.normalize(__dirname + '/views/css');

module.exports = [
  { path: '/',
    method: 'GET',
    config: {
      auth: false,
      handler: function(request, reply) {
        reply.view("index", {fortune:"everything is awesome"});
      }
    }
  },
  {
    method: 'GET',
    path: '/css/{param*}',
    config: {
      auth: false,
      handler: {
          directory: {
              path: cssdir
          }
      }
    }
  }
]
