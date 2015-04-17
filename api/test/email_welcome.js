var test   = require('tape');
var dir   = __dirname.split('/')[__dirname.split('/').length-1];
var file  = dir + __filename.replace(__dirname, '');
var uncache = require('./uncache').uncache;

uncache('../lib/email_welcome'); // clear cached email module
var APIKEY = process.env.MANDRILL_APIKEY; // store for later
process.env.MANDRILL_APIKEY = null; // delete key to force fail
var email  = require('../lib/email_welcome'); // no api key

test(file+" Force Fail in Email", function(t) {
  var person = {
    "email"    : 'bad@example.com',
    "password" : "thiswill400"
  }
  email(person, function(eres){
    console.log(eres);
    t.equal(eres.status, 'error', "Invalid Mandrill Key");
    process.env.MANDRILL_APIKEY = APIKEY; // restore key for next tests
    uncache('../lib/email_welcome'); // clear cached email module
    t.end();
  })
});
