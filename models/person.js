var Joi = require('joi');
module.exports = {
  payload: {
    person: Joi.string(), // unique id
    email:  Joi.string().email().required(),
    fn:     Joi.string(),
    ln:     Joi.string(),
    ct:     Joi.forbidden() // don't allow people to set this!
  }
}
