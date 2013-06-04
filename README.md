time
====

![Not everything that counts can be counted, 
and not everything that can be counted counts. ~ Albert Einstein
](http://i.imgur.com/ESOb79D.png "Not everything that counts can be counted")


**How Will You Measure Your Life?** http://youtu.be/tvos4nORf_Y

- - -

(Thought) Experiments in Time. JavaScript, CoffeeScript and Mocha

Ever since I read [Malcom Gladwell's Outliers]
(http://en.wikipedia.org/wiki/Outliers_(book))
I've "*clicked*" with the idea that I need to keep investing my time
and after **10,000 hours** I will acheive "**overnight success**". :-)

I've already dedicated **way** more than 10kh to learning
*everything* I can about technology, not just how to write code.

My only measure of *progress* (to date)
has been my own sense of acheivement.
(and my ability to whiz through my "day-job" coding tasks)

I want a better way to *measure* my life.
I want to track my progress towards *all* my goals, not just coding.

There are some goals which are more important than others.

I often watch Ted Talks e.g:
[Stop Learning, Start Thinking, Create Something](http://youtu.be/Uq-FOOQ1TpE)
[Hackschooling Makes Me Happy](http://youtu.be/h11u3vtcpaY)

But if I don't share them anywhere, is the time "*wasted*"...?
Or does watching inspiring videos which expose us to new thoughts/ideas 
*count* towards a goal...?


- - - - - - 

If you don't already know CoffeeScript (*shame on you*! :-P )
Here are a few resources:

- (Interactive) Online Book: http://autotelicum.github.com/Smooth-CoffeeScript/interactive/interactive-coffeescript.html
- 30min Tutorial: http://net.tutsplus.com/tutorials/javascript-ajax/rocking-out-with-coffeescript/

I still have not found a **complete beginners** guide to programming that focusses on **Javascript** *and* **TDD** ... might have to *write* one... :-)



If you are new to Socket.io, 

Read the *how-to* page: http://socket.io/#how-to-use

work your way through *this* tutorial:
http://net.tutsplus.com/tutorials/javascript-ajax/real-time-chat-with-nodejs-socket-io-and-expressjs/

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
