// /**
//  * This will delete your ElasticSearch Database
//  * obviously, only use it in development...
//  */
// var http;
// var ESOptions = {
//   host: '127.0.0.1',
//   port: '9200',
//   path: '/'+process.env.ES_INDEX, // DELETEs EVERYTHING!!
//   method: 'DELETE',
//   headers: { 'Content-Type': 'application/json' }
// };
// // DELETE all records on TEST ElasticSearch Instance
// if(process.env.SEARCHBOX_SSL_URL || process.env.BONSAI_URL) {
//   var url  = process.env.SEARCHBOX_SSL_URL || process.env.BONSAI_URL;
//   // console.log('ES url: '+url);
//   var unpw = url.split('://')[1].split(':');
//   var un   = unpw[0];
//   var pw   = unpw[1].split('@')[0];
//   var auth = (new Buffer(un + ':' + pw, 'utf8')).toString('base64');
//   ESOptions.headers['Authorization'] = 'Basic ' + auth;
//   ESOptions.host   = url.split('@')[1];
//   ESOptions.port   = 443;
//   http = require('https');
// } else {
//   http = require('http');
// }
//
// var drop = function(callback) {
//   var resStr = '';
//   var req = http.request(ESOptions, function(res) {
//     res.setEncoding('utf8');
//     var resStr = '';
//     res.on('data', function (chunk) {
//       resStr += chunk;
//     }).on('end', function () {
//       console.log(resStr);
//       console.log(' - - - - - - - - - - - - - - - - - - - - - - - - - - - - ');
//       callback(JSON.parse(resStr));
//     }).on('error', function(err){
//       console.log("FAIL: "+err);
//     });
//   });
//   return req;
// }
//
//
// module.exports = {
//   drop: drop
// }
//
// process.on('uncaughtException', function(err) {
//   console.log(__filename+' >> FAIL ' + err);
// });
