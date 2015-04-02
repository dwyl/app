
$(document).ready(function(){
  var t = document.getElementById('t');
  var counting;
  var timers = {};
  var start = function() {
    var st = new Date().getTime() - (4000 * 1000);
    console.log("START: "+st);
    counting = setInterval( function() {
      var now = new Date().getTime()
      var elapsed = now - st;
      t.innerHTML = timeformat(elapsed);
    }, 1000/3);
  }

  var timeformat = function(elapsed){
    var elapsed = Math.floor(elapsed/1000);
    // timer is less than 10 seconds
    if(elapsed < 10) {
      return "00:0"+elapsed
    }
    // timer is less than 1 minute
    else if(elapsed < 60) {
      return "00:"+elapsed
    } // 60*60 = 3600 (number of seconds in an hour)
    else if (elapsed < 3600) { // minutes
      var minutes = Math.floor(elapsed / 60);
      if(minutes < 10){
        minutes = "0"+minutes;
      }
      var seconds = elapsed % 60;
      if(seconds < 10) {
        seconds = "0"+seconds;
      }
      return "" + minutes +":"+seconds;
    } // 60*60*24 = 86400
    else { // minutes
      var hours = Math.floor(elapsed / 3600 );
      // if(hours < 10){
      //   hours = "0"+hours;
      // }
      // remove hours from elapsed:
      var elapsed = elapsed - (hours * 3600);

      var minutes = Math.floor(elapsed / 60);
      if(minutes < 10){
        minutes = "0"+minutes;
      }
      var seconds = elapsed % 60;
      if(seconds < 10) {
        seconds = "0"+seconds;
      }
      // return hours
      return ""+hours+":" + minutes +":"+seconds;
    }
  }

  //saves description to the timer


  var stop = function(){
    clearInterval(counting);
    // // Extract the text from the template .html() is the jquery helper method for that
    // var raw_template = $('#complete').html();
    // // Compile that into an handlebars template
    // var template = Handlebars.compile(raw_template);
    // // Retrieve the placeHolder where the Posts will be displayed
    // var placeHolder = $("#main");
    // // Create a context to render the template
    // var context = {"title": "First Post", "entry": "You can't stop me now!"};
    // // Generate the HTML for the template
    // var html = template(context);
    // // Render the posts into the page
    // placeHolder.append(html);
  }

  var sb = document.getElementById("stop"); // stop button
  sb.onclick = function() {

      return stop();
  };

  start(); // auto start when the page loads
  console.log('working!')

  // https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date
/*
  function displayTimer() {
    // initilized all local variables:
    var hours='00', minutes='00',
    miliseconds=0, seconds='00',
    time = '',
    timeNow = new Date().getTime(); // timestamp (miliseconds)

    T.difference = timeNow - T.timerStarted;

    // milliseconds
    if(T.difference > 10) {
      miliseconds = Math.floor((T.difference % 1000) / 10);
      if(miliseconds < 10) {
        miliseconds = '0'+String(miliseconds);
      }
    }
    // seconds
    if(T.difference > 1000) {
      seconds = Math.floor(T.difference / 1000);
      if (seconds > 60) {
        seconds = seconds % 60;
      }
      if(seconds < 10) {
        seconds = '0'+String(seconds);
      }
    }

    // minutes
    if(T.difference > 60000) {
      minutes = Math.floor(T.difference/60000);
      if (minutes > 60) {
        minutes = minutes % 60;
      }
      if(minutes < 10) {
        minutes = '0'+String(minutes);
      }
    }

    // hours
    if(T.difference > 3600000) {
      hours = Math.floor(T.difference/3600000);
      // if (hours > 24) {
      // 	hours = hours % 24;
      // }
      if(hours < 10) {
        hours = '0'+String(hours);
      }
    }

    time  =  hours   + ':'
    time += minutes + ':'
    time += seconds + ':'
    time += miliseconds;

    T.timerDiv.innerHTML = time;
  }

  function startTimer() {
    // save start time
    T.timerStarted = new Date().getTime()
    console.log('T.timerStarted: '+T.timerStarted)

    if (T.difference > 0) {
      T.timerStarted = T.timerStarted - T.difference
    }
    // update timer periodically
    T.timerInterval = setInterval(function() {
      displayTimer()
    }, 10);

    // show / hide the relevant buttons:
    document.getElementById('go').style.display="none";
    document.getElementById('stop').style.display="inline";
    document.getElementById('clear').style.display="none";
  }

  function stopTimer() {
    clearInterval(T.timerInterval); // stop updating the timer

    document.getElementById('stop').style.display="none";
    document.getElementById('go').style.display="inline";
    document.getElementById('clear').style.display="inline";
  }

  function clearTimer() {
    clearInterval(T.timerInterval);
    T.timerDiv.innerHTML = "00:00:00:00"; // reset timer to all zeros
    T.difference = 0;

    document.getElementById('stop').style.display="none";
    document.getElementById('go').style.display="inline";
    document.getElementById('clear').style.display="none";
  }
*/
}());