# Memrise minder for Beeminder #

## Introduction ##

Since [Beeminder](http://www.memrise.com/) does not integrate with [Memrise](http://www.memrise.com/), this simple script aims to provide a way of automatically minding your cumulative score.

## Current state ##

The only thing working now is getting the total number of points as an integer. Because [Memrise](http://www.memrise.com/) does not provide an API, the [Mechanize](http://mechanize.rubyforge.org/) gem is used.
  
## Usage ##

```sh
$ MEMRISE_USERNAME=AwesomePolyglot MEMRISE_PASSWORD=sup3rs3cr3t ./memrise.rb
```
