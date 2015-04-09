
$(document).ready(function() {
  // we re-use these functionally-scoped GLOBALS quite a bit (hence defining here)
  var t = $('#t'); // document.getElementById('t'); // do we need jQuery?
  var active = {}; // currently active (running) timer
  var counting;    // store timer interval
  var timers = {}; // store timers locally

  /**
   * timerupsert is our generic API CRUD method which allows us to
   * CREATE a new timer, UPDATE the description of the timer and
   * also the END (Update) time when people Stop the timer.
   * @param timer {object} (require) - the timer we want to CRUD
   * @param callback {function} (required) - do this after the update
   */
  var timerupsert = function(timer, callback) {
    console.log(" - - - - - - - - - -  before upsert: ")
    console.log(timer);
    if(!timer.start) {
      console.log("FAIL!")
      return false;
    }
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
        console.log(' - - - - - - - - timerupsert res:')
        console.log(res);
        active = res;   // assign the new/updated timer record to active
        saveTimer(res); // add it to our local db of timers
        // db.set();
        callback();
      },
      error: function(xhr, err) {
        console.log(err);
      }
    });
  }

  /**
   *
   */
  function saveTimer(timer) {
    if(!timers[timer.id]){
      timers[timer.id] = {};
    }
    for (var k in timer){
      if(timer.hasOwnProperty(k)){
        timers[timer.id][k] = timer[k];
      }
    }
    return;
  }

  /**
   * Because the validation in API uses the JOI Models, if we send a field
   * that is NOT allowed in the Model, we will get an error back.
   * See Open discussion for this: https://github.com/ideaq/time/issues/100
   */

  var removedissalowedfields = function(timer){
    delete timer.ct;    // see: models/timer.js (ct is not updatable!)
    delete timer.index;
    delete timer.type;
    delete timer.created;
    delete timer.took;
    return timer;
  }

  /**
   * start a new timer.
   */
  var start = function() {
    $('#start').hide();     // ensure the start button cant be clicked twice
    $('#stop').show();      // stop button visible when timer is running
    var st = new Date();          // start time Date object
    var timestamp = st.getTime(); // timestamp for calculations below
    var timer = { 'start' : st.toISOString() }; // set up the new timer record

    var desc = $('#desc').val();  // check if a description was set
    if(desc) { // only set a description on a new timer if set
      timer.desc = desc; // add it to the timer record
    }
    // create a new record:
    timerupsert(timer, function() {
      // console.log("started: "+active.start);
    });
    // console.log("START: "+st);
    counting = setInterval( function() {
      var now = new Date().getTime();  // keep checking what time it is.
      var elapsed = now - timestamp;   // difference from when we started
      t.html(timeformat(elapsed));     // set the timer in the UI
    }, 1000/3); // should we update the view more/less frequently?
  }

  /**
   *  Stop the currently running timer.
   *
   */
  var stop = function() {
    clearInterval(counting);
    var timer = active;
    timer.desc = $('#desc').val();
    timer.end = new Date().toISOString();
    timer.elapsed = new Date(timer.end).getTime() - new Date(timer.start).getTime();
    timer.took = timeformat(timer.elapsed);
    timerupsert(timer, function(){
      console.log("Timer Stopped");
      clearactive();
      rendertimers();
    });

    //hide/show relevant UI elements
    $('#why').hide();
    $('#desc').val('');
    $('#t').text('00:00');
    $('#stop').fadeOut();
    $('#start').fadeIn();
    return;
  }

  /**
   *  clearactive unsets the active global object so we can create a fresh timer
   */
  var clearactive = function(){
    // delete the active object's (own) properties
    for (var k in active){
      if(active.hasOwnProperty(k)){
        delete active[k]; // clear the active timer because we stopped it!
      }
    }
  }


  /**
   * timeformat returns a string in the format hh:mm:ss for rendering to UI
   */
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
   * rendertimers renders your list of past timers in the ui.
   * centralises all the view rendering.
   */
  var rendertimers = function() {
    // transform the timers Object to an Array so we can SORT it below:
    var arr = Object.keys(timers).map(function(id) {
    var timer = timers[id];
    timer.endtimestamp = new Date(timer.end).getTime(); // used to sort below
      return timer;
    });
    var byDate = arr.sort(function(a,b) {
      return b.endtimestamp - a.endtimestamp;
    });
    // Add timer to past-timers list using handlebars
    var raw_template = $('#timer_list_template').html();
    var template = Handlebars.compile(raw_template);
    var parent = $("#past-timers-list");
    var html = '';
    byDate.map(function(i){
      var timer = i // timers[i]
      timer.took = timeformat(timer.elapsed); // repetitive ...
      html += template(timer);
      console.log(" >>> "+i, timer);
    })
    parent.html(html); // completely re-write the DOM each time! :-O
    return;
  }

  /**
   * transform our timers object of timer objects into an array (list)
   * of timer ojbects. So we can sort by date... see: sort above
   */
   var timerlist = function() {
     return Object.keys(timers).map(function(id){
       return timers[id];
     })
    //  return arr;
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
   * db is our localStorage "database" (a stringified object)
   * which allows us to be "offline-first" for nowdb.get & db.set
   * are light wrappers around the respective localStorage methods
   * later on we could chose to use a more gracefully degrating approach
   * see: http://stackoverflow.com/a/12302790/1148249
   */
   var db = {
     set : function(key, value) {
       localStorage.setItem(key, JSON.stringify(value));
       return;
     },
     get : function(key) {
       return JSON.parse(localStorage.getItem(key));
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
    // desc.blur(function(){
    //   var newdesc = desc.val();
    //   console.log("Desc WAS: "+active.desc)
    //   console.log("Description was updated to "+ newdesc);
    //   active.desc = newdesc;
    //   timerupsert(active, function(){
    //     // console.log("Updated");
    //   });
    // });

    desc.change(function(){
      if(active.id) { // active timer exists
        var newdesc = desc.val();
        console.log("Desc WAS: "+active.desc)
        console.log("Description was updated to "+ newdesc);
        active.desc = newdesc;
        timerupsert(active, function(){
          console.log("Changed");
        });
      }
    })


    // enter key: http://stackoverflow.com/questions/979662
    // $(document).keypress(function(e) {
    //   if(e.which == 13) {
    //     alert('You pressed enter!');
    //   }
    // });


    $('#start').click(function() {
      start();
    })

  }

  var sb = $("#stop"); // stop button
  sb.click( function() {
    console.log("#stop Clicked!")
    return stop();
  });

  localStorage.clear();
  boot(function(){
    console.log('Booted.');
    start(); // auto start when the page loads
    listeners();
  });

  console.log('working!')

  // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date

});
