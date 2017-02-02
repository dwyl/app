var Joi = require('joi');
module.exports = {
  payload: {
    id        : Joi.string(), // unique id
    email     : Joi.string().email().required(),
    password  : Joi.string().required().min(4),
    firstname : Joi.string(),
    lastname  : Joi.string()
  }
}
