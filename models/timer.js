var Joi = require('joi');
module.exports = {
  payload: {
    person:  Joi.forbidden(),
    desc:    Joi.string().optional(),
    created: Joi.forbidden(), // don't allow people to set this!
    start:   Joi.date().iso(),
    end:     Joi.date().iso().optional(),
    aid:     Joi.string(),
    session: Joi.string().optional()
  }
}
