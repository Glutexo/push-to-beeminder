# Mind your Memrise total points to Beeminder! #

## Introduction ##

Since [Beeminder](http://www.beeminder.com/) does not integrate with [Memrise](http://www.memrise.com/), this simple script aims to provide a way of automatically minding your cumulative score. This script can be called by _cron_ or manually every time after doing some learning. It is designed to work with the _odometer_ (or “biker”) goal types, where the datapoints are cummulative, that means the total points scored from the very beginning until now.

## Requirements ##

* Ruby, Bunder.
* [Beeminder](http://www.beeminder.com/) account.
* [Memrise](http://www.memrise.com/) account.
  
## Usage ##

Running the Rake task “mind” fetches the total points from [Memrise](http://www.memrise.com/) and pushes a new datapoint to your [Beeminder](http://www.beeminder.com/) goal. It is pretty dumb as it does not verify anything. As far as the sign-in succeeds, the datapoint is created.

Before the first run call:

```sh
bundle install
```

Then push your datapoints by calling:

```sh
$ MEMRISE_USERNAME=AwesomePolyglot MEMRISE_PASSWORD=sup3rs3cr3t BEEMINDER_USERNAME=lazybones BEEMINDER_AUTH_TOKEN=d34df4c3bbqblah BEEMINDER_MEMRISE_GOAL=memrise rake
```

Fill the enviroment variables with your credentials. The `BEEMINDER_MEMRISE_GOAL` is the short (URL) name of your goal. Both username and auth token can be figured out from your goal URL: `https://www.beeminder.com/[username]/goals/[goal]`. Both username (again) and auth token can be retrieved on this URL: https://www.beeminder.com/api/v1/auth_token.json.

## Internals ##

Because [Memrise](http://www.memrise.com/) does not provide an API, [Mechanize](http://mechanize.rubyforge.org) gem is used to fetch the number of points.
