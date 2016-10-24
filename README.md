# time

[![Join the chat at https://gitter.im/dwyl/time](https://badges.gitter.im/dwyl/time.svg)](https://gitter.im/dwyl/time?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Build Status](https://travis-ci.org/dwyl/time.png?branch=master)](https://travis-ci.org/dwyl/time)
[![Node version](https://img.shields.io/node/v/atimer.svg?style=flat)](http://nodejs.org/download/)
[![HAPI 11.0.3](http://img.shields.io/badge/hapi-11.0.3-brightgreen.svg)](http://hapijs.com)


![Until we can manage time, we can manage nothing else](http://i.imgur.com/GbTyiib.png)


- - -
You *found* us, ***welcome!***     
We're currently *re-building* the ***Time*** **App** to make it more modular and extensible, if you want to help us ***Beta Test*** it,
please register your interest on the website: http://www.dwyl.io/

In the meantime, please feel free to [read through our repos](https://github.com/dwyl/start-here) and find out what we're about or [_drop us a line_](https://github.com/dwyl/start-here/issues) with questions, what you'd like to see us focus on, happy thoughts, great articles you've read lately or anything that's on your mind!

## Why? [![Start with Why](https://img.shields.io/badge/start%20with-why%3F-brightgreen.svg?style=flat)](http://www.ted.com/talks/simon_sinek_how_great_leaders_inspire_action)

> “*The* ***price*** *of anything is the* ***amount*** *of* ***life*** *you* ***exchange for it***.”
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

> Help us build it! https://github.com/ideaq/time/issues

### *Expected* Environment Variables˜

The API server will *not* work unless these
environment variables are set.

Run the following command to set up your local machine:
```sh
export ES_INDEX=dwyl
export MANDRILL_APIKEY='AskUsForTheKey!'

```
See [**.travis.yml**](https://github.com/ideaq/time/blob/master/.travis.yml)
for [Continuous integration](http://en.wikipedia.org/wiki/Continuous_integration) settings.

### Use Vagrant to Run ElasticSearch on your Local Machine

```sh
vagrant up
vagrant ssh
sudo service elasticsearch start
```


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
