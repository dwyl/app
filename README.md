# time
[![Build Status](https://travis-ci.org/ideaq/time.png?branch=master)](https://travis-ci.org/ideaq/time)
[![Test Coverage](https://codeclimate.com/github/ideaq/time/badges/coverage.svg)](https://codeclimate.com/github/ideaq/time)
[![Code Climate](https://codeclimate.com/github/ideaq/time.png)](https://codeclimate.com/github/ideaq/time)
[![bitHound Score](https://www.bithound.io/github/ideaq/time/badges/score.svg?)](https://www.bithound.io/github/ideaq/time) [![Dependencies](https://david-dm.org/ideaq/time.png?theme=shields.io)](https://david-dm.org/ideaq/time)
[![Node version](https://img.shields.io/node/v/atimer.svg?style=flat)](http://nodejs.org/download/)
[![HAPI 8.2](http://img.shields.io/badge/hapi-8.2-brightgreen.svg)](http://hapijs.com)


![Until we can manage time, we can manage nothing else](http://i.imgur.com/GbTyiib.png)

- - -

## Why? [![Start with Why](https://img.shields.io/badge/start%20with-why%3F-brightgreen.svg?style=flat)](http://www.ted.com/talks/simon_sinek_how_great_leaders_inspire_action)

> “*The **price** of anything is the **amount** of **life** you **exchange for it**.*”
~ Henry David Thoreau

Time (a *finite* amount it) is one of the few things we *all* have in common.  
Wether we like it or not, we each only have a ***fixed amount***.  
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
