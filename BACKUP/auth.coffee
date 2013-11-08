



console.log googleapis.discover()




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

