// bring your own validation function
var validateFunc = function (decoded, request, callback) {
  // console.log(" - - - decoded JWT token: - - -");
  // console.log(decoded);
  // console.log(" - - - request info: - - - - - -");
  // console.log(request.info);
  // console.log(" - - - user agent: " + request.headers['user-agent']);


    // do your checks to see if the person is valid
    // if (!people[decoded.id]) {
    //   return callback(null, false);
    // }
    // else {
      return callback(null, true);
    // }
};

module.exports = validateFunc
