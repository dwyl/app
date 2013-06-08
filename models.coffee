### MongoHQ Test ###

db = require('./config/db')
mongoose = require('mongoose')
mongoose.connect('mongodb://' + db.user + ':' + db.pass + '@' + db.host + ':' + db.port + '/' + db.name)

Schema = mongoose.Schema
 
msg = new Schema({
    m: String # message
    n: String # name of the person sending the message
    t: Number # timestamp for the message # { type: Date, default: Date.now } #
    p: String # id of parent message when threading
})
 
mongoose.model('msg', msg)