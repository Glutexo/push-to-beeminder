# Mind your cumulative Memrise or Duolingo points to Beeminder! #

## Introduction ##

Since [Beeminder](http://www.beeminder.com/) does not integrate with [Memrise](http://www.memrise.com/), this simple script aims to provide a way of automatically minding your cumulative score. This script can be called by _cron_ or manually every time after doing some learning. It is designed to work with the _odometer_ (or “biker”) goal types, where the datapoints are cummulative, that means the total points scored from the very beginning until now.

Along with [Memrise](http://www.memrise.com/), there is also a support for [Duolingo](http://www.duolingo.com/). Although [Beeminder](http://www.beeminder.com/) has [its own native support](https://www.beeminder.com/duolingo) for [Duolingo](http://www.duolingo.com/), it is able to track only one language at once. That is a different approach than [Duolingo](http://www.duolingo.com/) itself uses with its [Coach](https://www.duolingo.com/settings/coach). The [Coach](https://www.duolingo.com/settings/coach) tracks the daily points for all languages together. This script can be used to push the cumulative total score from all your [Duolingo](http://www.duolingo.com/) language courses.

## Requirements ##

* Ruby, Binder.
* A [Beeminder](http://www.beeminder.com/) account.
* A [Memrise](http://www.memrise.com/) or [Duolingo](http://www.duolingo.com/) account.
  
## Usage ##

Before the first run call:

```sh
bundle install
```

The minding itself is done by running a [Rake](https://github.com/ruby/rake) task `memrise` or `duolingo`. It reads your credentials from the environment. Example:

```sh
$ MEMRISE_USERNAME=AwesomePolyglot MEMRISE_PASSWORD=sup3rs3cr3t BEEMINDER_USERNAME=lazybones BEEMINDER_AUTH_TOKEN=d34df4c3bbqblah BEEMINDER_MEMRISE_GOAL=memrise rake memrise
```

or

```sh
$ DUOLINGO_USERNAME=AwesomePolyglot BEEMINDER_USERNAME=lazybones BEEMINDER_AUTH_TOKEN=d34df4c3bbqblah BEEMINDER_MEMRISE_GOAL=duolingo rake duolingo
```

Here is a list of environment variables used by this script:

### [Beeminder](http://www.beeminder.com/)

* `BEEMINDER_USERNAME` 
* `BEEMINDER_AUTH_TOKEN`
* `BEEMINDER_MEMRISE_GOAL`
* `BEEMINDER_DUOLINGO_GOAL`

Both `USERNAME` and `AUTH_TOKEN` can be found on this JSON URL, if you are signed in: https://www.beeminder.com/api/v1/auth_token.json. The `USERNAME` is also the last part of the URL of the _Your Goals_ page. E.g.: https://www.beeminder.com/ *lazybones*.

The `GOAL` variables take the last part of the URL of your Goal page. It is the value you filled in the “Your goal’s URL” upon creating the goal. E.g.: https://www.beeminder.com/lazybones/goals/ *memrise*.

### [Memrise](http://www.memrise.com/)

* `MEMRISE_USERNAME`
* `MEMRISE_PASSWORD`
* `BEEMINDER_MEMRISE_GOAL`

Because [Memrise](http://www.memrise.com/) does not provide an API, [Mechanize](http://mechanize.rubyforge.org) gem is used to fetch the number of points. It simulates a browser: it logs in on your behalf and loads the dashboard page, where the total number of points is stated. Neither the password, nor any cookies are stored. Every time the script is run, it makes a fresh log-in.

If something changes at [Memrise](http://www.memrise.com/), be it the login process or the [Dashboard](http://www.memrise.com/home/), this script might stop working.

### [Duolingo](http://www.duolingo.com/)

* `DUOLINGO_USERNAME`
* `BEEMINDER_DUOLINGO_GOAL`

Since [Duolingo](http://www.duolingo.com/) user profiles are publicly accessible, a username is enough to find all the data needed. There is no need to provide a password. Luckily enough, the use profile is readable in the _JSON_ format that means that it is less probable that this script will break because of changes in the [Duolingo](http://www.duolingo.com/) markup.
