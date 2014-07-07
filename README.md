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
Wether we like it or not, we each only have
It is our most precious non-renewable 'resource'. <br />
We need a *much* better way of keeping track of how we spend it.

## What?

A simple way to track activities over time.

### Original Idea

This is the ***sketch*** I did ages ago:
![time app sketch](https://raw.github.com/nelsonic/nelsonic.github.io/master/img/time-app-sketch.jpeg)

- [ ] Connect to CouchBase
- [ ] Create GET for all **public** viewable timers.
- [ ] Allow anyone to start a timer without registration/login



## How?

### Backend: Node.js + Hapi

```
git clone git@github.com:nelsonic/time.git
```
- [ ] publish npm module

![proposed module name](http://i.imgur.com/zvkM5k8.png)


### Database/Cache: CouchBase




#### Resources

- Node module: https://github.com/couchbase/couchnode
- Getting started: http://www.couchbase.com/communities/nodejs/getting-started

#### Background

**Q**: Why switch from CouchDB to CouchBase? <br />
**A**: Speed. (lower latency for reads/writes)

- Difference between CouchDB and CouchBase:
http://stackoverflow.com/questions/5578608/difference-between-couchdb-and-couchbase
- CouchDB vs CouchBase: http://www.couchbase.com/couchbase-vs-couchdb
- The future of CouchDB: http://damienkatz.net/2012/01/the_future_of_couchdb.html
- Understanding & Installing CouchBase: https://www.youtube.com/watch?v=28ws32sGqas
