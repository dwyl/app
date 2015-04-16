var nodemailer = require('nodemailer');
var fs         = require('fs');
var path       = require('path');
var templatedir = __dirname +'/../email_templates/';
var htmlpath   = path.resolve(templatedir + 'welcome_html.html');
var textpath   = path.resolve(templatedir + 'welcome_text.txt');
var template   = fs.readFileSync(htmlpath, 'utf8')
var textonly   = fs.readFileSync(textpath, 'utf8')
// create reusable transporter object using SMTP transport
var transporter = nodemailer.createTransport({
    service: 'Gmail',
    auth: {
        user: 'welcome.to.dwyl@gmail.com',
        pass: process.env.GMAIL_PASSWORD
    }
});

// NB! No need to recreate the transporter object. You can use
// the same transporter object for all e-mails

var email = function(person, callback){
  var mailOptions = {
    from: '#dwyl do what you love! <welcome.to.dwyl@gmail.com>', // sender
    to: person.email, // list of receivers
    subject: 'Welcome to dwyl!', // Subject line
    text: textonly, // plaintext body
    html: template
  };
  // send mail with defined transport object
  transporter.sendMail(mailOptions, function(error, info){
    // console.log(error, info);
    callback(error, info)
  });
}

module.exports = email;
