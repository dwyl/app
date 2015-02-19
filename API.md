

## Records

### Timer / Activity

+ **aid** - *activity identifier* - String - `Joi.string().optional()`
+ **ct** - *created time* - ISO Date - set by the *server*
(*cannot* be set by the user/api)
+ **desc** - *description* - String - `Joi.string().optional()`
+ **et** - *end time* - ISO Date - `Joi.date().iso()`
+ **st** - *start time* - ISO Date - `Joi.date().iso()`
