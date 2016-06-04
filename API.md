## Records

### Timer / Activity

+ **aid** - *activity identifier* - String - `Joi.string().optional()`
+ **ct** - *created time* - ISO Date - set by the *server*
(*cannot* be set by the user/api)
+ **desc** - *description* - String - `Joi.string().optional()`
+ **end** - *end time* - ISO Date - `Joi.date().iso()`
+ **start** - *start time* - ISO Date - `Joi.date().iso()`
