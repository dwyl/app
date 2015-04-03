module.exports = [
  { path: '/anonymous', method: 'GET',
    config: { auth: false, handler: require('./handlers/anonymous.js') } },
  { path: '/register', method: 'POST',
    config: { auth: false, validate: require('../models/person'),
    handler: require('./handlers/register.js') } },
  { path: '/login', method: 'POST',
    config: { auth: 'basic', handler: require('./handlers/login.js') } },
  { path: '/logout', method: 'POST',
    config: { auth: 'jwt', handler: require('./handlers/logout.js') } },
  { path: '/timer/{id}', method: 'GET', // Validate {id} to prevent injection?
    config: { auth: 'jwt', handler: require('./handlers/timer_find.js') } },
  { path: '/timer/all', method: 'GET', // Validate {id} to prevent injection?
    config: { auth: 'jwt', handler: require('./handlers/timer_find_all.js') } },
  { path: '/timer/new', method: 'POST',
    config: { validate: require('../models/timer'),
      auth: 'jwt', handler: require('./handlers/timer_start.js')
    }
  },
  { path: '/timer/upsert', method: 'POST',
    config: { validate: require('../models/timer'),
      auth: 'jwt', handler: require('./handlers/timer_update.js')
    }
  }
]
