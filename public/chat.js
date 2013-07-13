// Generated by CoffeeScript 1.6.2
(function() {
  window.onload = function() {
    var content, field, messages, sendButton, socket, val;

    window.url = window.location.href.toString();
    console.log("url: " + url);
    window.localStorage.setItem('value', 'my value');
    val = window.localStorage.getItem('value');
    console.log("val: " + val);
    messages = [];
    field = document.getElementById("field");
    sendButton = document.getElementById("send");
    content = document.getElementById("content");
    socket = io.connect(url);
    socket.on('message', function(data) {
      var html, msg, _i, _len;

      if (data.m) {
        messages.push(data.m);
        html = '';
        for (_i = 0, _len = messages.length; _i < _len; _i++) {
          msg = messages[_i];
          html += msg + '<br />';
        }
        return content.innerHTML = html;
      } else {
        return console.log("There is a problem:", data);
      }
    });
    return sendButton.onclick = function() {
      var text;

      text = field.value;
      return socket.emit('send', {
        m: text
      });
    };
  };

}).call(this);

/*
//@ sourceMappingURL=chat.map
*/