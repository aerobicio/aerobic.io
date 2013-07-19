[![Code Climate](https://codeclimate.com/repos/51ca61cc56b1023b06009574/badges/664073e19f2501b1fb61/gpa.png)](https://codeclimate.com/repos/51ca61cc56b1023b06009574/feed)

## README

Aerobic.io is a Fitness Tracking service by @quamen and @plasticine.

### Dependencies

* Git
* Ruby 2.0
* Rubygems
* Bundler
* Postgresql

### Getting Started

The following steps will get your development environment up and running:

    $ script/bootstrap
    $ rake db:migrate

As part of the bootstrap process we install a few binstubs:

    bin/autospec
    bin/rspec
    bin/cucumber

### Testing

We use three types of tests in the project:

1. Unit Tests
2. Acceptance Tests
3. Static Analysis Tools

To find out more about how we use each of these types of tests, please read
the [testing strategy document](https://github.com/quamen/aerobic.io/blob/master/doc/testing_strategy.markdown).

You can run the full test suite like so:

    $ script/cibuild

You can also run each individual test suite manually:

#### Unit Tests

    $ bin/rspec

#### Acceptance Tests

    $ bin/cucumber

#### Static Analysis Tools

    $ rake quality
