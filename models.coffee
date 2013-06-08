### MongoHQ Test ###

db = require('./config/db')
mongoose = require('mongoose')
mongoose.connect('mongodb://' + db.user + ':' + db.pass + '@' + db.host + ':' + db.port + '/' + db.name)

Schema = mongoose.Schema

msg = new Schema({
    m: String # message
    n: String # name of the person sending the message
    p: String # id of parent message when threading
    t: Number # timestamp for the message # { type: Date, default: Date.now } #
})
mongoose.model('msg', msg)

ppl = new Schema({
    email: String # should we allow more than one email address?  
    family_name: String # last name
    gender: String # F/M
    given_name: String # first name
    google_access_token: String # 
    google_id: String # global (google) user id
    google_id_token: String # OAuth Token
    google_link: String # link to google plus page
    google_oauth_code: String # code returned when user auths
    google_refresh_token: String # OAuth Refresh Token
    locale: String # two char lang code
    picture: String # profile picture
    name: String # full name of the person 
    verified_email: Boolean # self explanatory
})
mongoose.model('ppl', ppl)