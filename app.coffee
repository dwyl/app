express = require 'express'
app = express()
port = 80

app.use(express.static(__dirname + '/public'))
app.set('views', __dirname + '/tpl')
app.set('view engine', 'jade')
app.engine('jade', require('jade').__express)

app.get('/', (req, res) ->
    res.render('page')
)
 
app.get('/works', (req, res) ->
	console.dir(req.headers) # req.headers['user-agent']
	res.send('Works')
)
 
# app.listen(port);
io = require('socket.io').listen(app.listen(port))

io.sockets.on('connection', (socket) ->
	console.log('client connected ')
	console.log(socket.id)
	d = new Date()
	clock = d.toLocaleTimeString()
	socket.emit('message', { message: 'welcome to the chat '+clock })
	socket.on('send', (data) ->
		io.sockets.emit('message', data)
	)
)

# io.disable('heartbeats')

console.log("Listening on port " + port)