[![Maintainability](https://api.codeclimate.com/v1/badges/ee6695d41437428570f3/maintainability)](https://codeclimate.com/github/rvirani1/hargh/maintainability)
[![Build Status](https://travis-ci.org/rvirani1/hargh.svg?branch=master)](https://travis-ci.org/rvirani1/hargh)
[![Test Coverage](https://api.codeclimate.com/v1/badges/ee6695d41437428570f3/test_coverage)](https://codeclimate.com/github/rvirani1/hargh/test_coverage)
[![Open Source Love](https://badges.frapsoft.com/os/v2/open-source.svg?v=103)](https://github.com/ellerbrock/open-source-badges/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

<p align="center">
  <img src="readme_images/hargh.png" width="250">
</p>

# Hargh

* [Overview](#overview)
* [Design Thoughts](#design-thoughts)
* [Known Limitations](#known-limitations)
* [Running Locally](#running-locally)
* [Deployment](#deployment)
* [API Docs](#api-docs)
* [License](#license)

## Overview

Hargh allows you to store and query HAR records.
This project is to complete the
[Rigor coding exercise](https://goo.gl/p3b5V1).

## Design Thoughts

### Using Postgres and Building ActiveRecord Models

You'll notice that there are ActiveRecord models that tightly map to
the structure of the HAR spec. This initially felt kind of dangerous
because the HAR really is a spec for a document structure.

What if there was some variation in a browser vendor's HAR output
that couldn't be accomodated by the data model? What if there was a
change in the HAR spec? Let's say HAR 1.3. That led me to think that
perhaps using something like MongoDB and MongoDB that uses documents
natively would make the most sense in the long-term. That may still
be the case long-term.

However in this case, I think AR models work quite well. The schema of
the HAR spec seems remarkably consistent internally so that it's
fairly easy to map to attributes of a model. Furthermore if we
limit this small app to HAR 1.2, then we can essentially count on
those models not changing.

### Query Aggregates

### Data Script

## Known Limitations

* Only supports single page HARs

The HAR spec allows for files to include multiple pages.
However, this project currently only supports single page HARs.
We're essentially ignoring the `pageRef` key in each `entry`
for expediency right now.

* Issues with Unicode Sequences

Some web pages will include Unicode sequences. Since we store the raw
data in Postgres `jsonb` fields. There is a known issue since 9.4.1
with unicode sequences. A quick [Google Search](https://goo.gl/rH7tWF)
reveals a lot of information. We haven't tried to implement any of
the workarounds yet

* Performance

It might just be that we are validating and processing lots of data.
Some of these HAR files are quite large. Howver, the create and update
endpoints take half a second to a second to run. The logs show that the
issue is not in the view generation after the controller is done or at
the database layer. It also doesn't look like the schema validation is
causing the time delay. My suspicion for further investigation would
be the use of a `jsonb` column for the raw data storage. I wonder if the
Rails side has to do a lot of computation on these large data structures
before save. I'm also using `HashWithIndifferentAccess` everywhere. I
wonder if that also has a performance implication.

# Running Locally

1. Install the Ruby Version specified in the `.ruby-version` file via
RVM or RBenv

1. Install [PostgreSQL](https://www.postgresapp.com) and have it running

1. Clone the Repo and `cd` into it

1. Install Ruby dependencies via `bundle install`

1. Copy the `.env.example` file to `.env`

1. Set all values in the `.env` file.

1. Setup the database using `bundle exec rails db:setup`

1. Run the server using `bundle exec rails server`

# Developing Locally

This project relies on the excellent
[Overcommit gem](https://github.com/brigade/overcommit)
that adds Git hooks to run various linters and code checkers.
You'll need to run the following command to make sure
your code complies.

`overcommit --install`

## Deployment

If you don't want to bother with a local setup for now, just use the
Heroku deploy button below.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## API Docs

If you want to see the current API docs, you can check them out on the
deployed [Heroku Instance](https://hargh.herokuapp.com/docs)

# License

This project is licensed under the [MIT License](./LICENSE.md)
