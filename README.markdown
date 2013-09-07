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

### View Architecture

We handle views slightly differently to the traditional Rails approach.

#### Layouts != Views

We use [Nestive](https://github.com/rwz/nestive) to try and make our views leaner by attempting to push complexity up into the inherited layout system wherever possible.

This means that views should ideally be smaller and more concise, and should also mean that layouts are more reusable, and we have less repetition across the entirety of the View layer.

The default layout in the application is `authenticated.html.erb` - which is the most common layout for views in the app.

#### Views as Templates (Mustache Style ERB)

In an effort to make our view code unit testable and sane, we have adopted the
strategy of treating each .html.erb file as a template. Each template has its
own view object, that contains the logic for the view.

Our inspiration - [Mustache style ERB](http://warpspire.com/posts/mustache-style-erb/).

#### i18n Strings

Strings in views should always be i18n-ed. If the string is related only to a single view and is not reused anywhere else then the string should use a view-relative i18n path.

### Feature Flipping

We use [Rollout](https://github.com/bitlove/rollout) to flip features in our
user interface. Read the [Rollout](https://github.com/bitlove/rollout) docs
for more information on how it works.

A list of active feature flips can be found in [SwitchBoard::FEATURE_FLIPS](https://github.com/quamen/aerobic.io/blob/master/lib/switch_board.rb#L16).

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

If you can think of a way to make this seamless, open a pull request.

