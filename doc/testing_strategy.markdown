# Testing Strategy

This document covers the philosophy behind how we write tests for aerobic.io.
It is a living document and will be adjusted as we learn new things and change
the way in which we maintain the system.

There are three types of tests in the project:

1. Unit Tests
2. Acceptance Tests
3. Static Analysis Tools

Each type of tests is there for a specific reason, and is designed to serve a
different purpose.

We strive for a minimum of 100% code coverage accross our unit and acceptance
test suite. We measure this using
[simplecov](https://github.com/colszowka/simplecov).

## Unit Tests

Unit tests are written in [rspec](https://github.com/rspec/rspec-rails/) and
should test one unit of code.

When writing unit tests, the following rules should be adheared to:

1. Stub any class or module not under test.
2. Do not require spec helper unless you have to. Exception are granted for:
    * Controller tests.
3. Do no write to the database, disk, or make network calls. The only exception
   is for testing Models that inherit from ActiveRecord that have uniquness
   constraints on them.
4. Factories should never be used in unit Tests.
5. Unit tests for ActiveRecord models should require the active record helper,
   and not spec helper.

By following these rules we should have a very fast unit test squite that
proves that each unit of code works as intended. It makes no promises about
collaboration with other units of code.

## Acceptance Tests

Acceptance tests are written in
[cucumber](https://github.com/cucumber/cucumber-rails) and should test the
users interaction with the application from the browser.

When writing unit tests, the following rules should be adheared to:

1. One feature file per high level feature.
2. One step definition file for each feature file.
3. Logic shared accross features/steps should be moved into plain ruby methods
   in their own file located in the features/support directory.
4. Stubs should not be used in acceptance tests, the one exception is when
   dealing with methods that generate network requests.

## Static Analysis Tools

We use static analysis tools to keep ourselves honest.

* [Cane](https://github.com/square/cane) ensures that our code base
adhears to basic coding standards. It runs as part of our build.
* [Code Climate](https://codeclimate.com/) ensures that our code base adhears
  to basic coding standards, doesn't have obvious security holes, and measures
  churn on the code base. It is an external service that runs against master.
