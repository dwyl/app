#Minimum Viable Product ([MVP](http://theleanstartup.com/principles))

We're still working on this document so it should be constantly changing. _**All comments and pull requests welcome!**_

+ [MVP feature set](#MVP-Feature-set)
+ [Minimum UI](#Minimum UI)
  + **[Open Questions for MVP & beyond](#open-questions)**

<br/>

##MVP Feature set
[**Alpha feature set:**](https://github.com/ideaq/time/issues/67)
* Log in as a user (to enable timers to be saved)
* Log out
* Start a timer
* Stop that timer
* Give that timer a description
* Start a new timer

###Common points of friction
Day-to-day time tracking **can't feel like work** or it'll stop being an effective tool [upcoming blog post on this topic!]. What we really want is **the minimum number of steps** to accomplish our task - starting a timer.

So **what are the _biggest_ time wasters** to try and avoid?
* **Too much initial setup:** If you’re going to ask me to create all of my projects, rates or set up a bunch of timers **_up front, before I can start using the app_** in a useful way, that’s burdensome. I don’t even know _how_ I’m planning on using the app yet!
* **Too much overhead to start a timer:** Having to type a description and _then_ assign a category and _then_ decide what other options to add to my timer when really, all I want to do is start it and get on with life.

##[Minimum UI](https://github.com/ideaq/time/issues/31)
**Minimum solution to points of fiction:** Timer starts automatically when [people](https://github.com/ideaq/time/issues/33) open the app/webpage. Also allow them to start a timer _with **one tap**_ and _without_ the need to add further information to it.

###Screens
First partial UI sketch, keeping it as simple as possible. _To be iterated over._

_**Initial suggestion -**_ Minimal number and content of screens as follows:

* Main screen:
  * Timer, set to 00:00 to begin with (seconds & minutes, with hours added dynamically when required)
  * Description of timer with placeholder text
  * Log of today's (?) stopped timers
  * Simple login area, shown as default unless user is logged in already
* Additional items required at this point:
  * Some way of [knowing user is logged in](https://github.com/ideaq/time/issues/85)
  * Logout button

![First sketch](https://cloud.githubusercontent.com/assets/4185328/6601248/7717a73c-c80c-11e4-9a86-066934c90dce.jpg)

A few more sketches of potential **MVP alpha** screens to start understanding the user experience, leading to [more open questions](#open-questions):

![User experience screen flows](https://cloud.githubusercontent.com/assets/4185328/6856657/5f501c12-d3f9-11e4-9424-62774075afb2.jpg)

<a name="open-questions"/>
##Open Questions
Some of our UI open questions _**have**_ to be answered **before the MVP** as they touch our MVP feature set:
* Does the user need to press anything to submit/confirm the description of the timer?
* How does the user edit the timer description? Tap to edit?
* Do we need both an email and a password requested on the main screen or just an email?
* Should a new timer start automatically once a timer has been stopped?
* Do we [allow anonymous users to have run more than one timer](https://github.com/ideaq/time/issues/58) before they have to register to save them?
* What is the best way to [show a user they are logged in](https://github.com/ideaq/time/issues/85)?
* What is the simplest way to deal with [remembering users so they don't have to constantly log in](https://github.com/ideaq/time/issues/45) at MVP or should we be doing this at this stage at all?

Some initial questions **to be answered by the MVP** also surfaced whilst putting together the UI:
* Should the running/active timer take up so much screen real estate or would this be better utilised for something else?
* Should the [placeholder text for the timer description disappear as soon as a person is in the input field](https://github.com/ideaq/time/issues/92) or remain as a prompt until that person starts typing?
* How does someone edit the timer description? Tap to edit?
  * How does someone [edit a _past_ timer description](https://github.com/ideaq/time/issues/103)? Especially if tapping a past timer restarts it.
* If the description wraps over more than one line, [do we show the whole description or do we cut it off](https://github.com/ideaq/time/issues/105) and add '...' at the end
* Should _past_ timers shown on main page show the total time spent on that activity for a period (today or the current week for example) or just the last time the timer was used?
* [Should just today's timers be shown on the main page](https://github.com/ideaq/time/issues/113) of the app? Or Today + Yesterday? Or the full week?
  * Should past timers be shown in reverse chronological order (latest timer to have been stopped at the top/always visible without scrolling)?
* Should clicking on a _past_ timer on the main page [restart it](https://github.com/ideaq/time/issues/30#issuecomment-75047797)?
* Do we need both an email and a password requested on the main screen or just an email?
* What is the [most intuitive icon for prompting people for feedback](https://github.com/ideaq/time/issues/114#issuecomment-92297303) within the app?
