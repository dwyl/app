time
====

![Not everything that counts can be counted, 
and not everything that can be counted counts. ~ Albert Einstein
](http://i.imgur.com/ESOb79D.png "Not everything that counts can be counted")

Read a few of these: http://www.goodreads.com/quotes/tag/time ...

**How Will You Measure Your Life?** http://youtu.be/tvos4nORf_Y

- - -

(Thought) Experiments in Time. JavaScript, CoffeeScript and Mocha

Ever since I read [Malcom Gladwell's Outliers]
(http://en.wikipedia.org/wiki/Outliers_(book))
I've "*clicked*" with the idea that I need to *keep investing* my time
and after **10,000 hours** I will acheive "**overnight success**". :-)

I've already dedicated *way* more than **10kh** to learning
*everything* I can about technology, not just how to write code.

My only measure of *progress* (to date)
has been my own sense of acheivement.
(and my ability to whiz through my "day-job" coding tasks)
I want a better way to *measure* my life.
I want to track my progress towards *all* my goals.

There are some goals which are more important than others... 

I often watch Ted Talks e.g:

- [Stop Learning, Start Thinking, Create Something](http://youtu.be/Uq-FOOQ1TpE)
- [Hackschooling Makes Me Happy](http://youtu.be/h11u3vtcpaY)

But if I don't share them anywhere, is the time "*wasted*"...?
Or does watching inspiring videos which expose us to new thoughts/ideas 
*count* towards a goal...?

If I don't tell other people what I'm doing with my time,
everyone thinks I'm just being **"antisocial"** when I chose not to "go out".


- - - - - - 

### New to CoffeeScript?

Here are a few resources:

- (Interactive) Online Book: http://autotelicum.github.com/Smooth-CoffeeScript/interactive/interactive-coffeescript.html
- 30min Tutorial: http://net.tutsplus.com/tutorials/javascript-ajax/rocking-out-with-coffeescript/

I still have not found a **complete beginners** guide to programming that focusses on **Javascript** *and* **TDD** ... might have to *write* one... :-)



### New to Socket.io?

Background: https://github.com/LearnBoost/Socket.IO

Read the *how-to* page: http://socket.io/#how-to-use

work your way through *this* tutorial:
http://net.tutsplus.com/tutorials/javascript-ajax/real-time-chat-with-nodejs-socket-io-and-expressjs/

With Express: http://www.danielbaulig.de/socket-ioexpress/

#### FAQ

- http://stackoverflow.com/questions/4094350/good-beginners-tutorial-to-socket-io
- http://stackoverflow.com/questions/11974947/everyauth-vs-passport-js


### New to MongoHQ?

**Intro**: http://youtu.be/SLH6fujRYB8
**Tutorial**: http://j-query.blogspot.co.uk/2011/11/mongoose-and-mongohq.html

>> Mongoose: http://mongoosejs.com/
+ Mongoose Data Types: http://mongoosejs.com/docs/schematypes.html

>> MongoHQ: https://www.mongohq.com/home


### Google OAuth

General intro: https://developers.google.com/accounts/docs/OAuth2

JS: https://developers.google.com/api-client-library/javascript/features/authentication

Get API Keys: https://code.google.com/apis/console/?pli=1#access

Simple Example: https://code.google.com/p/google-api-javascript-client/source/browse/samples/authSample.html

Another more detailed example: https://developers.google.com/youtube/v3/guides/authentication
(it says youtube but its applicable to other services >> localhost)

I had a look at Passport: http://passportjs.org/guide/google/
and https://github.com/jaredhanson/passport-google-oauth
Its a good *ready-made* solution to G-Auth but it hides the interesting bits.

Also had a look at the "official" Google NodeJS Module: 
https://github.com/google/google-api-nodejs-client/blob/master/examples/oauth2.js
Its good...
But there is a notice saying its "alpha" and they cannot guarantee it future changes will be backward compatible.

To acccess user info (email address and name) we need:
http://stackoverflow.com/questions/7393852/name-email-from-googles-oauth-api

After much searching: https://developers.google.com/accounts/docs/OAuth2Login

Which lead me to: https://developers.google.com/+/

And: https://developers.google.com/+/quickstart/javascript

And: https://github.com/googleplus/gplus-quickstart-javascript

https://developers.google.com/+/features/sign-in

Resource Representation: https://developers.google.com/+/api/latest/people#resource


Watch List of Google + API Features: http://www.youtube.com/watch?v=EBf_OTPWmFk&feature=share&list=PL53B883EBFFAE300C

People Methods: https://developers.google.com/+/api/latest/people#methods


### Salesforce OAuth

http://developer.apigee.com/salesforce_tutorial.html


### Hypertable

Tutorial: https://code.google.com/p/hypertable/wiki/HQLTutorial


### HTML5 Local Storage

Simple example: http://www.w3schools.com/html/html5_webstorage.asp

Detailed spec: http://dev.w3.org/html5/webstorage/


- - - - - - 

Socket.io socket properties:


{ id: 'W3sFQ0jPl9BMdda8Jmb3',
  namespace: 
   { manager: 
      { server: [Object],
        namespaces: [Object],
        sockets: [Circular],
        _events: [Object],
        settings: [Object],
        handshaken: [Object],
        connected: [Object],
        open: [Object],
        closed: {},
        rooms: [Object],
        roomClients: [Object],
        oldListeners: [Object],
        sequenceNumber: 170288887,
        gc: [Object] },
     name: '',
     sockets: 
      { uoAnzIeoaJF5YkHfJmb2: [Object],
        W3sFQ0jPl9BMdda8Jmb3: [Circular] },
     auth: false,
     flags: { endpoint: '', exceptions: [] },
     _events: { connection: [Object] } },
  manager: 
   { server: 
      { domain: null,
        _events: [Object],
        _maxListeners: 10,
        _connections: 4,
        connections: [Getter/Setter],
        allowHalfOpen: true,
        _handle: [Object],
        httpAllowHalfOpen: false,
        _connectionKey: '4:0.0.0.0:3700' },
     namespaces: { '': [Object] },
     sockets: 
      { manager: [Circular],
        name: '',
        sockets: [Object],
        auth: false,
        flags: [Object],
        _events: [Object] },
     _events: 
      { 'set:transports': [Object],
        'set:store': [Function],
        'set:origins': [Function],
        'set:flash policy port': [Function],
        'set:flash policy server': [Function] },
     settings: 
      { origins: '*:*',
        log: true,
        store: [Object],
        logger: [Object],
        static: [Object],
        heartbeats: true,
        resource: '/socket.io',
        transports: [Object],
        authorization: false,
        blacklist: [Object],
        'log level': 3,
        'log colors': true,
        'close timeout': 60,
        'heartbeat interval': 25,
        'heartbeat timeout': 60,
        'polling duration': 20,
        'flash policy server': true,
        'flash policy port': 10843,
        'destroy upgrade': true,
        'destroy buffer size': 100000000,
        'browser client': true,
        'browser client cache': true,
        'browser client minification': false,
        'browser client etag': false,
        'browser client expires': 315360000,
        'browser client gzip': false,
        'browser client handler': false,
        'client store expiration': 15,
        'match origin protocol': false },
     handshaken: 
      { uoAnzIeoaJF5YkHfJmb2: [Object],
        W3sFQ0jPl9BMdda8Jmb3: [Object] },
     connected: { uoAnzIeoaJF5YkHfJmb2: true, W3sFQ0jPl9BMdda8Jmb3: true },
     open: { uoAnzIeoaJF5YkHfJmb2: true, W3sFQ0jPl9BMdda8Jmb3: true },
     closed: {},
     rooms: { '': [Object] },
     roomClients: 
      { uoAnzIeoaJF5YkHfJmb2: [Object],
        W3sFQ0jPl9BMdda8Jmb3: [Object] },
     oldListeners: [ [Object] ],
     sequenceNumber: 170288887,
     gc: { ontimeout: [Function] } },
  disconnected: false,
  ackPackets: 0,
  acks: {},
  flags: { endpoint: '', room: '' },
  readable: true,
  store: 
   { store: { options: undefined, clients: [Object], manager: [Object] },
     id: 'W3sFQ0jPl9BMdda8Jmb3',
     data: {} },
  _events: { error: [Function] } }


- - - - - - 

Express REQUEST Headers:

headers: 
   { host: 'localhost:3700',
     'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0',
     accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
     'accept-language': 'en-US,en;q=0.5',
     'accept-encoding': 'gzip, deflate',
     cookie: 'connect.sid=5Mn9s0aPdczA7wIJ8l4Oky5Z.ZEiqmY5FEBmwUAJ2NUo8y2wTP9wI2uToGje7bhLDDpI; __utma=111872281.368920661.1366385000.1369995394.1370009715.104; __utmz=111872281.1366648015.12.2.utmcsr=192.168.1.200:4000|utmccn=(referral)|utmcmd=referral|utmcct=/',
     connection: 'keep-alive',
     'cache-control': 'max-age=0' }

- - - - - - 

**console.log googleapis**


{ toBeDiscovered: [],
  cache: { opts: {} },
  transporter: {},
  authClient: null,
  GoogleApis: 
   { [Function: GoogleApis]
     BASE_DISCOVERY_URL_: 'https://www.googleapis.com/discovery/v1/apis/',
     DISCOVERY_TYPE_: 'rpc',
     DISCOVERY_PARAMS_: null },
  OAuth2Client: 
   { [Function: OAuth2Client]
     super_: [Function: AuthClient],
     GOOGLE_OAUTH2_AUTH_BASE_URL_: 'https://accounts.google.com/o/oauth2/auth',
     GOOGLE_OAUTH2_TOKEN_URL_: 'https://accounts.google.com/o/oauth2/token',
     GOOGLE_OAUTH2_REVOKE_URL_: 'https://accounts.google.com/o/oauth2/revoke' },
  auth: 
   { Compute: 
      { [Function: Compute]
        GOOGLE_OAUTH2_TOKEN_URL_: 'http://metadata/computeMetadata/v1beta1/instance/service-accounts/default/token',
        super_: [Object] },
     OAuth2Client: 
      { [Function: OAuth2Client]
        super_: [Function: AuthClient],
        GOOGLE_OAUTH2_AUTH_BASE_URL_: 'https://accounts.google.com/o/oauth2/auth',
        GOOGLE_OAUTH2_TOKEN_URL_: 'https://accounts.google.com/o/oauth2/token',
        GOOGLE_OAUTH2_REVOKE_URL_: 'https://accounts.google.com/o/oauth2/revoke' } },
  clientId_: undefined,
  clientSecret_: undefined,
  redirectUri_: undefined,
  opts: {},
  credentials: null }

- - - - - - 

console.log OAuth2Client

{ [Function: OAuth2Client]
  super_: [Function: AuthClient],
  GOOGLE_OAUTH2_AUTH_BASE_URL_: 'https://accounts.google.com/o/oauth2/auth',
  GOOGLE_OAUTH2_TOKEN_URL_: 'https://accounts.google.com/o/oauth2/token',
  GOOGLE_OAUTH2_REVOKE_URL_: 'https://accounts.google.com/o/oauth2/revoke' }

- - - - - - 

Google Plus API (Client)


{ clients: [],
  authClient: null,
  plus: 
   { apiMeta: 
      { kind: 'discovery#rpcDescription',
        etag: '"0kaFfN0xfjZjASExv-gUnrWhdto/uUdfqfQfk5l8S5trOJHTkhXzs14"',
        discoveryVersion: 'v1',
        id: 'plus:v1',
        name: 'plus',
        version: 'v1',
        revision: '20130525',
        title: 'Google+ API',
        description: 'The Google+ API enables developers to build on top of the Google+ platform.',
        ownerDomain: 'google.com',
        ownerName: 'Google',
        icons: [Object],
        documentationLink: 'https://developers.google.com/+/api/',
        protocol: 'rpc',
        rootUrl: 'https://www.googleapis.com/',
        rpcUrl: 'https://www.googleapis.com/rpc',
        rpcPath: '/rpc',
        parameters: [Object],
        auth: [Object],
        schemas: [Object],
        methods: [Object] },
     authClient: null,
     activities: { get: [Function], list: [Function], search: [Function] },
     comments: { get: [Function], list: [Function] },
     moments: { insert: [Function], list: [Function], remove: [Function] },
     people: 
      { get: [Function],
        list: [Function],
        listByActivity: [Function],
        search: [Function] } } }

- - - - - - 

**Google Plus Profile Response Object** : 
See: https://github.com/google/google-api-nodejs-client/blob/master/examples/oauth2.js
 for details.

{ kind: 'plus#person',
  etag: '"egWOTnJQshDUW7mcQ5TTH5LK5kQ/9rkacUsi9c86vyliF0FyT0j4oIA"',
  gender: 'male',
  urls: 
   [ { value: 'http://www.youtube.com/channel/UCQUk8BcANAxibcgEGc2cb7g',
       label: 'Nelson Correia' } ],
  objectType: 'person',
  id: '109403688002201304214',
  displayName: 'Nelson Correia',
  name: { familyName: 'Correia', givenName: 'Nelson' },
  url: 'https://plus.google.com/109403688002201304214',
  image: { url: 'https://lh4.googleusercontent.com/-nruPdhpK7gQ/AAAAAAAAAAI/AAAAAAAAABw/aBqfSKIManQ/photo.jpg?sz=50' },
  isPlusUser: true,
  verified: false }


- - - 

Sketch I did ages ago: 
![time app sketch](https://raw.github.com/nelsonic/nelsonic.github.io/master/img/time-app-sketch.jpeg)

