#Minimum Viable Product ([MVP](http://theleanstartup.com/principles))

We're still working on this document so it should be constantly changing. _**All comments and pull requests welcome!**_

##[MVP Feature set](https://github.com/ideaq/time/issues/67)
**Alpha:**
* Log in as a user (to enable timers to be saved)
* Start a timer
* Stop that timer
* Give that timer a description
* Start a new timer
* _[Add category to that timer](#mvp-categorisation)?_

<br/>
##Common points of friction
Day-to-day time tracking **can't feel like work** or it'll stop being an effective tool [upcoming blog post on this topic!]. What we really want is **the minimum number of steps** to accomplish our task - starting a timer.

So **what are the _biggest_ time wasters** to try and avoid?
* **Too much initial setup:** If you’re going to ask me to create all of my projects, rates or set up a bunch of timers **_up front, before I can start using the app_** in a useful way, that’s burdensome. I don’t even know _how_ I’m planning on using the app yet!
* **Too much overhead to start a timer:** Having to type a description and _then_ assign a category and _then_ decide what other options to add to my timer when really, all I want to do is start it and get on with life.

<br/>
##[Minimum UI](https://github.com/ideaq/time/issues/31)
**Minimum solution to points of fiction:** Allow [people](https://github.com/ideaq/time/issues/33) to start a timer _with **one tap**_ and _without_ the need to add further information to it. Any necessary details can be filled in later _(at this stage)_.

**To be considered post MVP:** Allow people to fill in additional timer details at the same time as they start the timer.

<a name="mvp-categorisation"/>
###The great categorisation debate
The question of _'Should we include categorisation as part of the MVP?'_ has been raised. [One camp suggests this is not part of 'the bare necessities'](https://github.com/ideaq/time/issues/67#issuecomment-78227827) and should be a feature voted on by the community.

The other camp suggests that given the [Minimum UI](#minimum-ui) currently proposed, categorisation **is** an MVP feature because otherwise people will end up with a mass of timers and **won't remember what they were all for** when they need to come back to them.

Our goal is to save people time and I would argue that **timer data needs to have either a description or a category attached for it to be useful** enough so that some conclusions can be drawn from it.

_**[Conclusion required!](https://github.com/ideaq/time/issues/67)** - suggest this feature is built last in the sprint if there's time_

###Screens
_**Initial suggestion -**_ Minimal number and content of screens as follows:
* Simple login screen, shown as default unless user is logged in already
* Main screen:
  * Timer, set to 00:00 to begin with (**open question:** seconds & minutes with hours added dynamically when required?)
  * Log of today's stopped timers (**open question:** just today's? Should MVP[alpha] be concerned with displaying more than today's data despite it being saved?)
  * _[TBC](https://github.com/ideaq/time/issues/67) - categories activated with one tap_
  * _[TBC](https://github.com/ideaq/time/issues/67) - description field for timer_

* Additional items required at this point:
  * Logout button
