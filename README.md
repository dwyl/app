# time [![Build Status](https://travis-ci.org/ideaq/time.png?branch=master)](https://travis-ci.org/ideaq/time) [![Code Climate](https://codeclimate.com/github/ideaq/time.png)](https://codeclimate.com/github/ideaq/time) [![Dependencies](https://david-dm.org/ideaq/time.png?theme=shields.io)](https://david-dm.org/ideaq/time)


![Not everything that counts can be counted,
and not everything that can be counted counts. ~ Albert Einstein
](http://i.imgur.com/ESOb79D.png "Not everything that counts can be counted")

Watch: **How Will You *Measure* Your Life?**
http://youtu.be/tvos4nORf_Y  
and ***Don't waste people's time***: http://ecorner.stanford.edu/authorMaterialInfo.html?mid=3404

- - -

## Why?

“***The price of anything is the amount of life you exchange for it.***”
~ Henry David Thoreau

Time (a *finite* amount) is one of the few things we *all* have in common.  
Wether we like it or not, we each only have a ***fixed amount***.  
It is our most precious ***non-renewable*** 'resource'.  
We need a *much* better way of keeping track of how we spend it.
˜
## What?

A simple way to track activities over time.

### Original Idea

This is the ***sketch*** I did ages ago:
![time app sketch](https://raw.github.com/nelsonic/nelsonic.github.io/master/img/time-app-sketch.jpeg)


## How?

### Backend: Node.js + Hapi.js + ElasticSearch

```
git clone git@github.com:nelsonic/time.git
```
- [ ] publish npm module

![proposed module name](http://i.imgur.com/zvkM5k8.png)


### Database ElasticSearch

+ [x] Brush up on ElasticSearch: https://github.com/nelsonic/learn-elasticsearch
+ [ ] Insert a new timer: (a) Start Date/Time (b) Short description
{start: new Date.getTime(), desc: "Brush teeth"}
+ [ ] Create GET for all **public** viewable timers.
+ [ ] Allow anyone to start a timer without registration/login
+ [ ] Ask the user if they want to store the GPS Lat/Lng for their activity


#### Resources

- Node module (for connecting to ElasticSearch): https://github.com/nelsonic/esta

#### FAQ

**Q**: **Why not** use MySQL or **PostgreSQL**?  
**A**: **No schema migrations** (no down-time).


## Research

- A google search for [**time tracking app**](https://www.google.com/search?q=time+tracking+app)
 yields "about" ***108 Million results***
 ![Google search for time tracking app](http://i.imgur.com/wnGWp3F.png)

## API

Our core objective is build a ***Great API*** from day one.


#### Curious About APIs?

> Here's some research/notes: https://github.com/nelsonic/learn-api-design
