module.exports = [
  { path: '/',
    method: 'GET',
    config: {
      auth: false,
      handler: function(request, reply) {
        reply.view("index", {fortune:"everything is awesome"});
      }
    }
  }
]
