var Joi = require('joi');
module.exports = {
  payload: {
    person: Joi.forbidden(),
    desc: Joi.string().optional(),
    ct: Joi.forbidden(), // don't allow people to set this!
    st: Joi.date().iso(),
    et: Joi.date().iso().optional(),
    aid: Joi.string()
  }
}
