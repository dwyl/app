time [![Build Status](https://travis-ci.org/nelsonic/time.png?branch=master)](https://travis-ci.org/nelsonic/time) [![Code Climate](https://codeclimate.com/github/nelsonic/time.png)](https://codeclimate.com/github/nelsonic/time) [![Dependencies](https://david-dm.org/nelsonic/time.png?theme=shields.io)](https://david-dm.org/nelsonic/time)
============
![Not everything that counts can be counted,
and not everything that can be counted counts. ~ Albert Einstein
](http://i.imgur.com/ESOb79D.png "Not everything that counts can be counted")


Watch: **How Will You Measure Your Life?** http://youtu.be/tvos4nORf_Y

- - -

## Why?

“***The price of anything is the amount of life you exchange for it.***”
~ Henry David Thoreau

Time (a *finite* amount of) is one of the few things we *all* have in common. <br />
Wether we like it or not, we each only have a ***fixed amount***. <br />
It is our most precious ***non-renewable*** 'resource'. <br />
We need a *much* better way of keeping track of how we spend it.

## What?

A simple way to track activities over time.

### Original Idea

This is the ***sketch*** I did ages ago:
![time app sketch](https://raw.github.com/nelsonic/nelsonic.github.io/master/img/time-app-sketch.jpeg)


## How?

### Backend: Node.js + Hapi.js

```
git clone git@github.com:nelsonic/time.git
```
- [ ] publish npm module

![proposed module name](http://i.imgur.com/zvkM5k8.png)


### Database/Cache: CouchBase


- [x] Download: http://www.couchbase.com/download#cb-server
- [x] Install the "Developer Preview" of Couchnode:

```
npm install couchbase@2.0.0-dp1 --save
```

- [x] Connect to CouchBase from Node
- [x] Write mock/test for Couchbase CRUD (see: test/db.js)
- [ ] Insert a new timer: (a) Start Date/Time (b) Short description
{start: new Date.getTime(), desc: "Brush teeth"}
- [ ] Create GET for all **public** viewable timers.
- [ ] Allow anyone to start a timer without registration/login
- [ ] Ask the user if they want to store the GPS Lat/Lng for their activity


Using https://github.com/couchbase/couchnode @v.1.2.4 <br/>
I attempt to connect to CouchBase server using the code in the README

```
var couchbase = require('couchbase');
var cluster = new couchbase.Cluster();
var db = cluster.openBucket('default');

db.set('testdoc', {name:'Frank'}, function(err, result) {
  if (err) throw err;

  db.get('testdoc', function(err, result) {
    if (err) throw err;

    console.log(result.value);
    // {name: Frank}
  });
});
```

but am getting an error:

```sh
time/test/db.js:2
var cluster = new couchbase.Cluster();
              ^
TypeError: undefined is not a function
```
See: **test/db.js**

Posting this to StackOverflow to get some help.

#### Resources

- Node module: https://github.com/couchbase/couchnode
- Getting started: http://www.couchbase.com/communities/nodejs/getting-started

#### Background

**Q**: **Why not** use MySQL or **PostgreSQL**? <br />
**A**: **No schema migrations** (no down-time) and CouchBase
has built-in (in-memory) caching for lower latency.

**Q**: Why switch from CouchDB to CouchBase? <br />
**A**: Speed. (lower latency for reads/writes)

- Difference between CouchDB and CouchBase:
http://stackoverflow.com/questions/5578608/difference-between-couchdb-and-couchbase
- CouchDB vs CouchBase: http://www.couchbase.com/couchbase-vs-couchdb
- The future of CouchDB: http://damienkatz.net/2012/01/the_future_of_couchdb.html
- Understanding & Installing CouchBase: https://www.youtube.com/watch?v=28ws32sGqas

> - [ ] Leave comment on: http://suyati.com/mongodb-vs-couchbase/

### Search

> - [ ] Investigate: http://docs.couchbase.com/couchbase-elastic-search/


## Background / Research

- A google search for [**time tracking app**](https://www.google.com/search?q=time+tracking+app)
 yields "about" ***108 Million results***
 ![Google search for time tracking app](http://i.imgur.com/wnGWp3F.png)

## Understanding APIs

Wondering what the difference between PUT and POST is?

http://stackoverflow.com/questions/630453/put-vs-post-in-rest
