var test   = require('tape');
var server = require("../../web.js");
var dir    = __dirname.split('/')[__dirname.split('/').length-1];
var file   = dir + __filename.replace(__dirname, '') + " -> ";
var timer;
var token;

test(file + "CREATE a NEW Timer without a desc (which we will update below)", function(t) {
  var options = { method : "GET", url : "/anonymous" };
  server.inject(options, function(res) {
    console.log(res.headers.authorization);
    token = res.headers.authorization;
    // blank timer
    var options = {
      method: "POST",
      url: "/timer/new",
      headers : { authorization : token }
    };
    server.inject(options, function(response) {
      t.equal(response.statusCode, 200, "New Timer Created: "+response.result.start);
      timer = response.result;
      t.end();
      server.stop();
    });
  });
});

test(file + "POST /timer/update to set a description", function(t) {
  timer.desc = "updated now";
  // person field is not allowed.
  delete timer.person;
  delete timer.created;
  delete timer._version;
  delete timer._id;
  delete timer._index;
  delete timer._type;
  
  var options = {
    method: "POST",
    url: "/timer/update",
    payload: timer,
    headers : { authorization : token }
  };
  server.inject(options, function(response) {
    console.log(response.result);
    t.equal(response.statusCode, 200, "Timer description updated to: "
      + response.result.desc +'\n');
    t.end();
    server.stop();
  });
});
