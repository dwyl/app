express = require 'express'
app = express()
port = 80

models = require('./models')
mongoose = require('mongoose')
MSG = mongoose.model('msg')
PPL = mongoose.model('ppl')

app.use(express.static(__dirname + '/public'))
app.set('views', __dirname + '/tpl')
app.set('view engine', 'jade')
app.engine('jade', require('jade').__express)

app.get('/', (req, res) ->
    res.render('page')
)
 
googleapis = require('googleapis')
OAuth2Client = googleapis.OAuth2Client

CLIENT_ID = '998322373435.apps.googleusercontent.com'
CLIENT_SECRET = 'U8QgUx2ygHzI-n5txUPMgcYV'
REDIRECT_URL = 'http://localhost/oauth2callback'

oauth2Client = new OAuth2Client(CLIENT_ID, CLIENT_SECRET, REDIRECT_URL)

# these are the various Google Services you want to access:
scopes = [
	'https://www.googleapis.com/auth/plus.login'
	'https://www.googleapis.com/auth/userinfo.profile'
	'https://www.googleapis.com/auth/userinfo.email'
	# 'https://www.googleapis.com/auth/calendar'
]

app.get('/login', (req, res) ->
	googleapis.discover('oauth2', 'v2').execute( (err, client) ->
		url = oauth2Client.generateAuthUrl({
			access_type: 'offline',
			scope: scopes.join ' '
		})
		res.send("<a href='#{url}'>click to login</a>")
	# console.log('Visit the url: ', url)
	)
	console.dir(req.headers) # req.headers['user-agent']

)

app.get('/oauth2callback', (req, res) ->
	code = req.query.code
	console.log "OAUth Response Code: "+code
	res.send code

	oauth2Client.getToken(code, (err, tokens) ->
		console.log tokens
		oauth2Client.credentials = tokens;
		googleapis.discover('oauth2', 'v2').execute( (err, client) ->
			console.log ' - - - - - - - - - - - - '
			console.log client
			console.log ' - - - - - - - - - - - - '
			# console.log client.oauth2.userinfo.get
			client.oauth2.userinfo.get({ email:'email'})
			.withAuthClient(oauth2Client)
			.execute((err, profile) ->
				if (err)
					console.log 'An error occurred'
					console.dir err
				else
					console.log 'Profile 1 :: '
					# console.log(profile)
					person = new PPL({
						google_id: profile.id
						email: profile.email # should we allow more than one email address?
						verified_email: profile.verified_email # self explanatory
						name: profile.name # full name of the person 
						given_name: profile.given_name # first name
						family_name: profile.family_name # last name
						google_link: profile.link # link to google plus page
						picture: profile.picture # profile picture
						gender: profile.gender # F/M
						locale: profile.locale # two char lang code
						google_id_token: tokens.id_token # OAuth Token
						google_refresh_token: tokens.refresh_token # OAuth Refresh Token
						google_access_token: tokens.access_token # 
						google_oauth_code: code
					})
					person.save( (err) ->
						if (err)
							return err;
						else
							console.log "Person: "+person
					)

				
			) # END .execute			
		) # END googleapis.discover.execute
	)
)
 
# app.listen(port);
io = require('socket.io').listen(app.listen(port))

io.sockets.on('connection', (socket) ->
	console.log('client connected ')
	console.log(socket.id)
	d = new Date()
	clock = d.toLocaleTimeString()
	socket.emit('message', { m: 'welcome to the chat '+clock })
	socket.on('send', (data) ->
		io.sockets.emit('message', data)
		console.log "Sent Data: "
		console.dir data
		msg = new MSG({
			m: data.m
			n: "Yash Kumar" 
			t: new Date().getTime()
		})

		msg.save( (err) ->
			if (err)
				return err;
			else
		  	console.log "Saved Message: "+msg
		)
	)
)

# io.disable('heartbeats')

console.log("Listening on port " + port)