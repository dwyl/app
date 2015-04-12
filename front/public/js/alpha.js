
$(document).ready(function() {
  // we re-use these functionally-scoped GLOBALS quite a bit (hence defining here)
  var t = $('#t'); // document.getElementById('t'); // do we need jQuery?
  var active = {}; // currently active (running) timer
  var counting;    // store timer interval
  var timers = {}; // store timers locally
  var DEFAULTDESC = "Tap/click here to update the description for this timer";
  var EMAIL;
  var JWT;
  var COIN = new Audio("http://www.orangefreesounds.com/wp-content/uploads/2014/08/Mario-coin-sound.mp3");
  /**
   * timerupsert is our generic API CRUD method which allows us to
   * CREATE a new timer, UPDATE the description of the timer and
   * also the END (Update) time when people Stop the timer.
   * @param timer {object} (require) - the timer we want to CRUD
   * @param callback {function} (required) - do this after the update
   */
  var timerupsert = function(timer, callback) {
    // console.log(" - - - - - - - - - -  before upsert: ")
    // console.log(timer);
    if(!timer.start) {
      console.log("FAIL!")
      return false;
    }
    timer = removedissalowedfields(timer);
    $.ajax({
      type: "POST",
      headers: {
        Authorization: JWT
      },
      url: "/timer/upsert",
      data: timer,
      dataType: "json",
      success: function(res, status, xhr) {
        console.log(' - - - - - - - - timerupsert res:')
        console.log(res);
        if(active && active.id === res.id){
          active = res;  
        }
        db.set('active', res)
        saveTimer(res); // add it to our local db of timers
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
    if(!timers) {
      timers = {}
    }
    if(!timers[timer.id]){
      timers[timer.id] = {};
    }
    for (var k in timer){
      if(timer.hasOwnProperty(k)){
        timers[timer.id][k] = timer[k];
      }
    }
    db.set('timers', timers);
    return;
  }

  /**
   * Because the validation in API uses the JOI Models, if we send a field
   * that is NOT allowed in the Model, we will get an error back.
   * See Open discussion for this: https://github.com/ideaq/time/issues/100
   */

  var removedissalowedfields = function(timer){
    delete timer.placeholder;
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
   * continue an existing timer (e.g. when the page is refreshed or re-opened)
   */
  var keeptiming = function() {
    $('#start').hide();     // ensure the start button cant be clicked twice
    $('#stop').show();      // stop button visible when timer is running
    var timer = active;     // set up the new timer record
    // console.log("START: "+st);
    if(timer.desc !== DEFAULTDESC){
      $('#desc').val(timer.desc);
    }
    var timestamp = new Date(timer.start).getTime();
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
    console.log(' - - - - - - ACTIVE:')
    console.log(active);
    var timer = active;
    timer.desc = $('#desc').val();
    if(!timer.desc || timer.desc.length < 1){
      timer.desc = DEFAULTDESC
    }
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
   *  clearactive unsets the active GLOBAL object so we can create a fresh timer
   */
  var clearactive = function(){
    // delete the active object's (own) properties
    for (var k in active){
      if(active.hasOwnProperty(k)){
        delete active[k]; // clear the active timer because we stopped it!
      }
    }
    clearInterval(counting);
    return db.set('active', {});
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
  var rendertimers = function(edit, id) {
    var byDate = timerlist();
    // Add timer to past-timers list using handlebars
    var raw_template = $('#timer_list_template').html();
    var template = Handlebars.compile(raw_template);
    var editor_template_raw = $('#timer_edit_template').html();
    var editor_template = Handlebars.compile(editor_template_raw);
    var parent = $("#past-timers-list");
    var html = '';
    byDate.map(function(timer) {
      // don't show active timer in list of past timers
      if(timer.id === active.id) {
        return;
      }
      timer.took = timeformat(timer.elapsed); // repetitive ...
      // show edit form if render called with edit true and an id
      if(timer.desc === DEFAULTDESC && id) {
        timer.placeholder = DEFAULTDESC;
        timer.desc = "";
      }
      if(edit && timer.id === id) {
        html += editor_template(timer);
      }
      else {
        html += template(timer);
      }
      // console.log(" >>> "+i, timer);
    })
    parent.html(html); // completely re-write the DOM each time! :-O
    // attach a listener event to each timer list entry
    byDate.map(function(timer){
      editlistener(timer.id); // multiple listeners...?
    });
    if(id){
      $('#'+id+'-desc').focus();
      // cursor at END of input field see: http://stackoverflow.com/a/4609476/1148249
      $('#'+id+'-desc').val($('#'+id+'-desc').val());
    }
    return;
  }

  /**
   * transform our timers object of timer objects into an array (list)
   * of timer ojbects. So we can sort by date...
   */
   var timerlist = function() {
     // transform the timers Object to an Array so we can SORT it below:
     var arr = Object.keys(timers).map(function(id) {
       var timer = timers[id];
       timer.endtimestamp = new Date(timer.end).getTime(); // used to sort below
       return timer;
     });
     var byDate = arr.sort(function(a,b) {
       return b.endtimestamp - a.endtimestamp;
     });
     return byDate;
   }

  /**
   * db is our localStorage "database" stores a string or stringified object
   * which allows us to be "offline-first" for nowdb.get & db.set
   * are light wrappers around the respective localStorage methods
   * later on we could chose to use a more gracefully degrating approach
   * see: http://stackoverflow.com/a/12302790/1148249
   */
   var db = {
     set : function(key, value) {
       if(typeof value === 'object'){
         value = JSON.stringify(value);
       }
       localStorage.setItem(key, value);
       return;
     },
     get : function(key) {
       var value = localStorage.getItem(key);
      //  console.log(key, value);
       try{
         var obj = JSON.parse(value);
         return obj;
       }
       catch(e){
         console.log(e);
         // value is not a stringified object
         return value;
       }
     }
   }

  /**
   *  All event listeners go here
   */
  var listeners = function() {
    var desc = $('#desc');
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

    $('#login').submit(function(event){
      event.stopImmediatePropagation();
      event.preventDefault();
      return login_or_register();
    })

    $('#start').click(function() {
      return start();
    })

    $("#stop").click( function() {
      console.log("#stop Clicked!")
      return stop();
    });

    $("#clear").click( function() {
      localStorage.clear(); // erase all history (client-side only)
      boot(function(){
        console.log("#clear localStorage - erase session/JWT & timers");
        clearactive();
        timers = {}; // make sure timers are cleared!
        rendertimers(); // re-render list
        return start();
      })
    });
  }


  var editlistener = function(id) {
    console.log(' - - - - - - edit listener - - - - -');
    var ed = $('#'+id);
    // first clear any existing listeners so we aren't doubling up
    ed.off("click"); // http://stackoverflow.com/a/825193/1148249
    // add a new listner for the entire li element
    ed.click(function(e) {
      rendertimers('edit', this.id);

    });
    // add a listener for clicking save button for this timer.
    $('#'+id+"-save").click(function(event){
      event.stopImmediatePropagation(); // don't submit the form just process it
      event.preventDefault();
      var timer = timers[this.id.replace('-save','')]; // get the timer id
      timer.desc = $('#'+id+"-desc").val();
      if(timer.desc.trim().length === 0) {
        timer.desc = DEFAULTDESC;
      }
      timer.took = $('#'+id+"-took").val();
      timerupsert(timer, function(){
        rendertimers();
      });
    })
    return;
  }

  /**
   * login attemps to log the person in using the email address and password
   * they have entered into the reg/login form. If login succeeds we display
   * the "nav" informing them of this. else we attempt to register them.
   */
   var login_or_register = function(){
     var person = {
       email: $('#email').val(),
       password: $('#password').val()
     };
     // >> input validation here!

     JWT = localStorage.getItem('JWT');
     $.ajax({
       type: "POST",
       headers: {
         Authorization: JWT
       },
       url: "/login-or-register",
       data: person,
       dataType: "json",
       success: function(res, status, xhr) {
         console.log(' - - - - - - - - LOGIN res:')
         console.log(res);
         if(res.timers && res.timers.length > 0) {
           console.log(' - - - - - - - - TIMERS:')
           console.log(res.timers[0])
           res.timers.map(function(timer){
             timers[timer._id] = timer._source;
           })
           rendertimers();
         }
         COIN.play();

         $('#login').fadeOut();
         $('#nav').fadeIn();
       },
       error: function(xhr, err) {
         console.log(xhr);
         console.log(err);
       }
     });
   }

  /**
   * loadtimers fetches existing timers from API
   *
   */
   var loadtimers = function() {
     // first render the LOCAL timers
     timers = db.get('timers');
     active = db.get('active');
     console.log(' - - - - - - ACTIVE:')
     console.log(active);
     console.log(' - - - - - - TIMERS:')
     console.log(timers);

     if(timers && timers.length !== 0) {
       $('#why').hide();
       rendertimers(); // don't render past timers if there aren't any!
     }
     if(active && active.id) {
       keeptiming();
       $('#desc').val(active.desc);
     }
     else{
       start(); // auto start when the page loads
     }
   }

  /**
   * boot checks if the person has used the app before
   * takes a callback
   */
  var boot = function(callback) {
    // check if the person already has a session
    JWT = localStorage.getItem('JWT');
    if(JWT) {
      console.log('existing person', JWT);
      return callback();
    } else {
      $.ajax({
        type: "GET",
        url: "/anonymous",
        dataType: "json",
        success: function(res, status, xhr) {
          console.log(res);
          // localStorage.setItem('person', res._id);
          localStorage.setItem('JWT', xhr.getResponseHeader("authorization"));
          JWT = xhr.getResponseHeader("authorization");
          // alert(xhr.getResponseHeader("authorization"));
          return callback();
        }
      });
    }
  } // END boot

  boot(function(){
    console.log('Booted.');
    loadtimers();
    listeners();
  });

  console.log('working!')
});
