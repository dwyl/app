# time
[![Build Status](https://travis-ci.org/dwyl/time.png?branch=master)](https://travis-ci.org/dwyl/time)
[![Node version](https://img.shields.io/node/v/dwyl.svg?style=flat)](http://nodejs.org/download/)
[![HAPI 11.0.3](http://img.shields.io/badge/hapi-11.0.3-brightgreen.svg)](http://hapijs.com)


![Until we can manage time, we can manage nothing else](http://i.imgur.com/GbTyiib.png)

- - -
You *found* us, ***welcome!***     
We're currently *re-building* the ***Time*** **App** to make it more modular and extensible, if you want to help us ***Beta Test*** it,
please register your interest on the website: http://www.dwyl.com/

In the meantime, please feel free to [read through our repos](https://github.com/dwyl/start-here) and find out what we're about or [_drop us a line_](https://github.com/dwyl/start-here/issues) with questions, what you'd like to see us focus on, happy thoughts, great articles you've read lately or anything that's on your mind!

## Why? [![Start with Why](https://img.shields.io/badge/start%20with-why%3F-brightgreen.svg?style=flat)](http://www.ted.com/talks/simon_sinek_how_great_leaders_inspire_action)


> “_The **price** of anything is the **amount** of **life** you **exchange for it**._”
~ Henry David Thoreau

Time (a *finite* amount it) is one of the few things we *all* have in common.  
Whether we like it or not, we each only have a ***fixed amount***.  
It is our most precious ***non-renewable*** 'resource'.  
We need a *much* better way of keeping track of how we spend it.
˜

> More detail: https://github.com/ideaq/time/issues/19

+ Watch: **How Will You *Measure* Your Life?**
http://youtu.be/tvos4nORf_Y  
+ and ***Don't waste people's time***: http://ecorner.stanford.edu/authorMaterialInfo.html?mid=3404

## What?

A simple way to track activities over time.

## How? [![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/ideaq/time/issues)

> Help us build it! https://github.com/dwyl/time/issues



### Run the Project _Locally_

+ Download Node.js: https://nodejs.org/en/download/
+ Download PostgreSQL: https://wiki.postgresql.org/wiki/Detailed_installation_guides
+ Download Redis: https://github.com/dwyl/learn-redis#installation

### _Clone_ the Repository

```sh
git clone https://github.com/dwyl/time.git && cd time
```

### _Install_ the Dependencies

```sh
npm install
```

### _Required_ Environment Variables

The server will *not* work unless these environment variables are set.

We _recommend_ you create a file called `.env`
Run the following command to set up your local machine:
```sh
export DATABASE_URL=postgres://postgres:@localhost/dwyl
export JWT_SECRET=https://git.io/vaN7A
```

See [**.travis.yml**](https://github.com/ideaq/time/blob/master/.travis.yml)
for [Continuous integration](http://en.wikipedia.org/wiki/Continuous_integration) settings.

### _Create_ PostgreSQL Database

To run this app you will need to have ***PostgreSQL Installed and Running*** on your local machine
***before*** you attempt to run this example.
> see: https://wiki.postgresql.org/wiki/Detailed_installation_guides



### No Registration Required

Try without registering: https://github.com/ideaq/time/issues/58

## API

Our core objective is build a ***Great API*** from day one.


#### Curious About APIs?

> Here's some research/notes: https://github.com/nelsonic/learn-api-design


<!--
### Sketch

This is the ***sketch*** I did ages ago:
![time app sketch](https://raw.github.com/nelsonic/nelsonic.github.io/master/img/time-app-sketch.jpeg)
-->
