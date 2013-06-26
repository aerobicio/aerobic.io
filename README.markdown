[![Code Climate](https://codeclimate.com/repos/51ca61cc56b1023b06009574/badges/664073e19f2501b1fb61/gpa.png)](https://codeclimate.com/repos/51ca61cc56b1023b06009574/feed)

== README

=== Dependencies

* Ruby 2.0
* Rubygems
* Bundler
* SQLite

=== Getting Started

These steps will eventually be wrapped up into a bootstrap script. For now,
run them manually:

    $ bundle
    $ cp .env.example .env
    $ rake db:create db:migrate
