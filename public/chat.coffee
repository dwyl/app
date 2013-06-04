window.onload = () ->
    window.url = window.location.href.toString()
    console.log "url: #{url}"
    messages = []
    field = document.getElementById("field");
    sendButton = document.getElementById("send");
    content = document.getElementById("content");

    init = () ->
        socket = io.connect(url); 
        socket.on('message', (data) ->
            if(data.message)
                messages.push(data.message);
                html = ''
                for msg in messages
                    html += msg + '<br />';
                content.innerHTML = html
            else
                console.log("There is a problem:", data)
        )
     
        sendButton.onclick = () ->
            text = field.value;
            socket.emit('send', { message: text })

    setTimeout(init(), 100)

    # socket.emit('send', {message: 'hello'} )
