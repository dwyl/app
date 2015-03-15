var http = require('http');

var options = {
  host: process.env.ES_HOST,
  port: process.env.ES_PORT,
  path: "/_all", // DELETEs EVERYTHING!!
  method: 'DELETE',
  headers: { 'Content-Type': 'application/json' }
};

var drop = function(callback) {
  var resStr = '';
  var req = http.request(options, function(res) {
    res.setEncoding('utf8');
    var resStr = '';
    res.on('data', function (chunk) {
      resStr += chunk;
    }).on('end', function () {
      callback(JSON.parse(resStr));
    }).on('error', function(err){
      console.log("FAIL: "+err);
    });
  });
  return req;
}

module.exports = drop;
