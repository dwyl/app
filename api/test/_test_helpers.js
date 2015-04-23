var server = require("../../web.js");
var COUNTDOWN = 0;
var N = 0
/**
 * create starts a timer for the given session/person.
 * ALL parameters are required. (non-optional!)
 * @param {object} t - the tape test context (used to call t.equal & t.end() )
 * @param {string} token - the Signed JWT we need to make our requests
 * @param {function} callback - function called once all records created.
 *   @param {object} res - the last response object from record creation
 *   @param {object} t - the tape test context we received.
 */
function create(t, token, callback) {
  var timer = {
    "desc" : "My Amazing Timer #"+COUNTDOWN,
    "start" : new Date().toISOString()
  }
  var options = {
    method: "POST",
    url: "/timer/new",
    payload: timer,
    headers : { authorization : token }
  };
  server.inject(options, function(res) {
    COUNTDOWN--;
    // console.log(" >>> "+countdown + " res.created "+ T.created);
    if(COUNTDOWN === 0) {
      var T = JSON.parse(res.payload);
      t.equal(res.statusCode, 200, N+ " New timers started! " + T.start);
      callback(res, t, token);
    }
  });
}

/**
 * create_many does exactly what its name suggests: creates many records
 * for the given session/person. ALL parameters are required. (non-optional!)
 * @param {integer} n - the number of records you want to create
 * @param {object} t - the tape test context (used to call t.equal & t.end() )
 * @param {string} token - the Signed JWT we need to make our requests
 * @param {function} callback - function called once all records created.
 *   @param {object} res - the last response object from record creation
 *   @param {object} t - the tape test context we received.
 */
function create_many(n, t, token, callback) {
  COUNTDOWN = N = n;
  for(var i = 0; i < n; i++) {
    create(t, token, callback);
  } // end for
}


/**
 * finish simply finishes the currently running test, not really a
 * decoupled utility yet; still specific to the /test/timer_find_all.js tests...
 * @param {object} res - response object from record creation
 * @param {string} token - the Signed JWT we need to make our requests
 * @param {object} t - the tape test context (used to call t.equal & t.end() )
 */
function finish(res, t, token){
  // console.log(res);
  var T = JSON.parse(res.payload);
  var tid = T.id;
  var options = {
    method: "GET",
    url: "/timer/"+tid,
    headers : { authorization : token }
  };

  server.inject(options, function(res) {
    t.equal(res.statusCode, 200, "New timer retrieved!"+'\n');
    server.stop();
    t.end();
  });
}


module.exports = {
  create_many: create_many,
  finish: finish
}

process.on('uncaughtException', function(err) {
  console.log(__filename+' >> FAIL ' + err);
  // console.log('Tip: Remember to start the Vagrant VM and Elasticsearch DB!')
});
