[![Code Climate](https://codeclimate.com/repos/51ca61cc56b1023b06009574/badges/664073e19f2501b1fb61/gpa.png)](https://codeclimate.com/repos/51ca61cc56b1023b06009574/feed)

== README

=== Dependencies

* Git
* Ruby 2.0
* Rubygems
* Bundler
* SQLite

=== Getting Started

The following steps will get your development environment up and running:

    $ script/bootstrap
    $ rake db:migrate

As part of the bootstrap process we install a few binstubs:

    bin/autospec
    bin/rspec
    bin/cucumber

=== Running Tests

You can run the full test suite like so:

    $ script/cibuild

You can also run each individual test suite manually:

==== Rspec

    $ bin/rspec

==== Cucumber

    $ bin/cucumber

==== Cane

    $ rake quality
