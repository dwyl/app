
$(document).ready(function(){
  var t = document.getElementById('t');
  var active = {}; // currently active (running) timer
  var counting;    // store timer interval
  var timers = {}; // store timers locally

  /**
   * update updates the description of the timer and
   * also the end time when people stop the timer.
   * @param timer {object} (require)
   * @param callback {function} (required)
   */
  var timerupsert = function(timer, callback) {
    console.log(" - - - - - - - - - -  timer: ")
    console.log(timer);
    console.log(" - - - - - - - - - - - - - - - -")
    timer = removedissalowedfields(timer);
    var jwt = localStorage.getItem('jwt');
    $.ajax({
      type: "POST",
      headers: {
        Authorization: jwt
      },
      url: "/timer/upsert",
      data: timer,
      dataType: "json",
      success: function(res, status, xhr) {
        // console.log(res);
        active = res;   // assign the new/updated timer record to active
        timers[res.id] = res; // add it to our local db of timers
        db.set();
        callback();
      },
      error: function(xhr, err) {
        console.log(err);
      }
    });
  }

  var removedissalowedfields = function(timer){
    delete timer.ct;    // client is not allowed to SET/UPDATE ct
    delete timer.index;
    delete timer.type;
    delete timer.created
    return timer;
  }

  var start = function() {
    var st = new Date();
    var timer = { start : st.toISOString() };
    var timestamp = st.getTime(); // - (200 * 1000);
    // create a new record:
    timerupsert(timer, function(){
      console.log("started: "+timer.start);
    });
    // console.log("START: "+st);
    counting = setInterval( function() {
      var now = new Date().getTime()
      var elapsed = now - timestamp;
      t.innerHTML = timeformat(elapsed);
    }, 1000/3);
  }

  var timeformat = function(elapsed){
    var h, m, s;
    elapsed = Math.floor(elapsed/1000);
    // timer is less than 10 seconds
    if(elapsed < 10) {
      return "00:0"+elapsed
    }
    // timer is less than 1 minute
    else if(elapsed < 60) {
      return "00:"+elapsed
    } // 60*60 = 3600 (number of seconds in an hour)
    else if (elapsed < 3600) { // minutes
      m = Math.floor(elapsed / 60);
      if(m < 10){
        m = "0"+m;
      }
      s = elapsed % 60;
      if(s < 10) {
        s = "0"+s;
      }
      return "" + m +":"+s;
    } // 60*60*24 = 86400
    else { // minutes
      h = Math.floor(elapsed / 3600 );
      // if(hours < 10){
      //   hours = "0"+hours;
      // }
      // remove hours from elapsed:
      elapsed = elapsed - (h * 3600);

      m = Math.floor(elapsed / 60);
      if(m < 10){
        m = "0"+m;
      }
      s = elapsed % 60;
      if(s < 10) {
        s = "0"+s;
      }
      // return hours
      return ""+h+":" + m +":"+s;
    }
  }
  /**
   *  Stop the currently running timer.
   *
   */
  var stop = function() {
    clearInterval(counting);
    var timer = active;
    timer.end = new Date().toISOString();
    timerupsert(timer, function(){
      console.log("Timer Stopped");
    });

    //*Add timer to past-timers list using handlebars */
    var raw_template = $('#timer_list_template').html();
    var template = Handlebars.compile(raw_template);
    var placeHolder = $("#past-timers");

    var elapsed = new Date(timer.end).getTime() - new Date(timer.start).getTime();
    // Generate the HTML for the template
    timer.took = timeformat(elapsed);
    var context = {took: timer.took, desc: timer.desc}
    var html = template(context);
    // Render the posts into the page
    placeHolder.append(html);
  }

  /**
   * boot checks if the person has used the app before
   * takes a callback
   */
  var boot = function(callback) {
    // check if the person already has a session
    if(localStorage.getItem('jwt')) {
      console.log('existing person', localStorage.getItem('jwt'));
      return callback();
    } else {
      $.ajax({
        type: "GET",
        url: "/anonymous",
        dataType: "json",
        success: function(res, status, xhr) {
          console.log(res);
          // localStorage.setItem('person', res._id);
          localStorage.setItem('jwt', xhr.getResponseHeader("authorization"));
          // alert(xhr.getResponseHeader("authorization"));
          callback();
        }
      });
    }
  } // END boot

  /**
   * db is our localstorage "database" (a stringified object)
   * which allows us to be "offline-first"
   */
   var db = {
     set : function() {
       localStorage.setItem('_db', JSON.stringify(timers));
       return;
     },
     get : function() {
       return JSON.parse(localStorage.getItem('_db'));
     }
   }

  /**
   *  All event listeners go here
   */
  var listeners = function() {
    var desc = $('#desc');
    desc.focus(function(){
      // are we going to clear the placeholder?
    });

    //saves description to the timer
    desc.blur(function(){
      var newdesc = desc.val();
      console.log("Desc WAS: "+active.desc)
      console.log("Description was updated to "+ newdesc);
      var timer = active;
      timer.desc = newdesc;
      timerupsert(timer, function(){
        console.log("Updated");
      });
    });

  }

  var sb = $("#stop"); // stop button
  sb.click( function() {
    console.log("#stop Clicked!")
    return stop();
  });
  console.log("hello ines!")

  localStorage.clear();
  boot(function(){
    console.log('Booted.');
    start(); // auto start when the page loads
    listeners();
  });

  console.log('working!')

  // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date

});
