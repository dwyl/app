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
    path: '/public/{param*}',
    config: {
      auth: false,
      handler: {
          directory: {
              listing: true,
              path: require('path').normalize(__dirname + '/public')
          }
      }
    }
  }
]
