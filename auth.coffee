googleapis = require('googleapis')
OAuth2Client = googleapis.OAuth2Client

CLIENT_ID = '998322373435.apps.googleusercontent.com'
CLIENT_SECRET = 'U8QgUx2ygHzI-n5txUPMgcYV'
REDIRECT_URL = 'http://localhost/oauth2callback'

console.log googleapis.discover()

googleapis.discover('plus', 'v1').execute( (err, client) ->
	# console.log client
	oauth2Client = new OAuth2Client(CLIENT_ID, CLIENT_SECRET, REDIRECT_URL)
	# console.dir oauth2Client
	url = oauth2Client.generateAuthUrl({
		access_type: 'offline',
		scope: 'https://www.googleapis.com/auth/userinfo.email'
	})
	# console.log('Visit the url: ', url)
)


# googleapis.discover('urlshortener', 'v1').execute( (err, client) ->
# 	client.urlshortener.url.get({ shortUrl: 'http://goo.gl/DdUKX' })
# 	.execute( (err, result) ->
# 		# result.longUrl contains the long url.
# 		console.log result.longUrl
# 	)
# )

# OAuth2Client = googleapis.OAuth2Client

# oauth2Client = new OAuth2Client(CLIENT_ID, CLIENT_SECRET, REDIRECT_URL)

# # generates a url that allows offline access and asks permissions
# # for Google+ scope.
# var url = oauth2Client.generateAuthUrl({
#   access_type: 'offline',
#   scope: 'https://www.googleapis.com/auth/plus.me'
# });

