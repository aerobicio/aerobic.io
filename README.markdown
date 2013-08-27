[![Code Climate](https://codeclimate.com/repos/51ca61cc56b1023b06009574/badges/664073e19f2501b1fb61/gpa.png)](https://codeclimate.com/repos/51ca61cc56b1023b06009574/feed)

## README

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

### Feature Flipping

We use [Rollout](https://github.com/bitlove/rollout) to flip features in our
user interface. Read the [Rollout](https://github.com/bitlove/rollout) docs
for more information on how it works.

We currently have the following feature flips active:
  * "Sign Up" - Renders links to the sign up page if turned on. Status: OFF

### CI

[Wercker](http://wercker.com) is used to run a build on every branch pushed
to [Github](http://github.com). If a build fails, it will show up in our
[Campfire](https://aerobicio.campfirenow.com/room/541059/) room.

Passing builds are expected and will not be announced in Campfire.

### Deployment

Deployment is handled automatically by [Wercker](http://wercker.com). Any build
of master that passes will be automatically deployed to the staging environment
at [beta-aerobic.herokuapp.com](http://beta-aerobic.herokuapp.com).

#### Environment Variables

If a new branch requires new environment variables to be set on Heroku, then
the pull request must indicate that this has already occured before it can be
merged. Otherwise [beta-aerobic.herokuapp.com](http://beta-aerobic.herokuapp.com)
will crash due to missing configuration.

#### Migrations

[Wercker](http://wercker.com) does not run migrations for you. If you are merging
a branch that requires migrations to be run, you must run them once the build
has been deployed.

If you can think of a way to make this seemless, open a pull request.

