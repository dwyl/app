module.exports = [
  { path: '/', method: 'GET',
    config: {
      auth: false,
      handler: require('./handlers/home')
    }
  }
]
