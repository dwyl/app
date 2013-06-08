window.onload = () ->
    window.url = window.location.href.toString()
    console.log "url: #{url}"
    # lookup previous session information in localStorage:
    window.localStorage.setItem('value', 'my value')
    val = window.localStorage.getItem('value')
    console.log "val: #{val}"

    messages = []
    field = document.getElementById("field");
    sendButton = document.getElementById("send");
    content = document.getElementById("content");

    # init = () ->
    socket = io.connect(url); 
    socket.on('message', (data) ->
        if(data.m)
            messages.push(data.m);
            html = ''
            for msg in messages
                html += msg + '<br />';
            content.innerHTML = html
        else
            console.log("There is a problem:", data)
    )
 
    sendButton.onclick = () ->
        text = field.value;
        socket.emit('send', { m: text })

    # setTimeout(init(), 100)

    # socket.emit('send', {message: 'hello'} )
