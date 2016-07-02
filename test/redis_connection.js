// var redisClient = require('redis-connection')();
// var test        = require('tape');
// var dir         = __dirname.split('/')[__dirname.split('/').length-1];
// var file        = dir + __filename.replace(__dirname, '') + " -> ";
//
// test(file +" Confirm RedisCloud is accessible GET/SET", function(t) {
//   redisClient.set('redis', 'working');
//   redisClient.get('redis', function (err, reply) {
//     t.equal(err, null);
//     // console.log(err, reply);
//     t.equal(reply.toString(), 'working', 'RedisCLOUD is ' +reply.toString());
//     t.end();
//   });
// });
//
// test.onFinish(function () {
//   redisClient.quit();
// })
