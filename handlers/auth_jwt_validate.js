// bring your own validation function
var validateFunc = function (decoded, callback) {

    // console.log("- - - - JWT - - - - ");
    // console.log(decoded);
    // console.log("- - - - - - - - - - ");

    // do your checks to see if the person is valid
    // if (!people[decoded.id]) {
    //   return callback(null, false);
    // }
    // else {
      return callback(null, true);
    // }
};

module.exports = validateFunc
