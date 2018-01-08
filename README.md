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
* [Steps](#steps)
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

## Steps

### Step 1

You can perform CRUD operations on a HAR file by sending it API requests.
See the [docs](https://hargh.herokuapp.com). For example, you can create
a new HAR record by sending a `POST` request to `/hars` where the body
is the JSON data of the HAR.

Yes, I know the docs aren't the most beautiful. I was giving a new gem
[RSpec API Documentation](https://github.com/zipmark/rspec_api_documentation)
a try. It generates docs from your API specs

The input is validated against what I think is the whole spec, not just
some pieces. I wanted to give
[dry-validation](https://github.com/dry-rb/dry-validation)
a shot and try to put it through the ringer. It performed very well.
Check out [har_schema.rb](lib/schemas/har_schema.rb)

### Step 2

This is the interesting part. For these, you're going to look at the
`/hars/:id/entries` and `/hars/:id/entries/aggregations` endpoints.
To answer the questions in the instructions, you might run some
queries like this:

#### Longest Blocked Timing

`/hars/1/entries?sort=timings_blocked&direction=desc&limit=1`

#### Shortest Blocked Timing

`/hars/1/entries?sort=timings_blocked&direction=asc&limit=1`

#### Second Shortest Blocked Timing

`/hars/1/entries?sort=timings_blocked&direction=asc&limit=1&offset=1`

#### Average BodySize

`/hars/1/entries/aggregations?column_name=response_content_size&operation=average`

#### Total BodySize

`/hars/1/entries/aggregations?column_name=response_content_size&operation=sum`

#### All Entries With Some Request URL

`/hars/1/entries?url=something`

There are a number of other queries or mixes of the same params we could do.
We could run similar mean or sum queries on the other timing measurements.
I think we should also add a max and min aggregation that would help us
figure out if there was an outlier that was unfairly skewing the results
up or down. I think we should also add an index/search endpoint for the
HAR records themselves. We currently cache the number of entries. Perhaps
there is a correlation between entry_count and load time. Although, some of
the entries may be loaded asynchronously, so it may not matter.

## Design Thoughts

### Using Postgres and Building ActiveRecord Models

There is a Postgres database backing up this API. However, there are
a couple of alternative approaches I can think of right away.

1. Don't parse key datapoints into their own columns. Just use Rails and
Postgres support for `jsonb`. This would make it easier to dynamically
query for whatever we wanted across a document structure. However, it
still feels kind of complicated. The Postgres process of adding and
managing `jsonb` indexes to support specific types of queries is also
not straightforward.

1. Use MongoDB and Mongoid. This makes a lot of sense for this use case.
We're attempting to store and query a spec that is a JSON document, so
let's use a document database. It's not very 'Railsy', but MongoDB
aggregations also make a lot of sense for this use case.

### Query Aggregates

You'll notice that there is a general `aggregations` endpoint for the
entries rather than something super specific to the questions asked. I
think it makes a lot of sense to have a more generalized endpoint where
you pass in one of a set number of numerically-typed columns that we've
already indexed (`column_name` parameter on the `aggregations` endpoint)
and then another parameter if we want it summed or meaned (`operation`
paramter on the `aggregations` endpoint). We can easily expand this to
allow for mins, maxes, medians with this pattern.

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
reveals a lot of information. I haven't tried to implement any of
the workarounds yet

* Performance

It might just be that we are validating and processing lots of data.
Some of these HAR files are quite large. Howver, the create and update
endpoints take half a second to a second to run. The logs show that the
issue is not in the view generation or at
the database layer. It also doesn't look like the schema validation is
causing the time delay. My suspicion for further investigation would
be the use of a `jsonb` column for the raw data storage. I wonder if the
Rails side has to do a lot of computation on these large data structures
before save. I'm also using `HashWithIndifferentAccess` everywhere. I
wonder if that also has a performance implication.

* Test Quality

The high coverage may fool you. However, some of the tests right now
are not very thorough and don't effectively use mocks. Again, this can
be remedied with time. However, the current test suite provides a lot
of bang for the buck.

* Error Handling

This just isn't fully baked in the interest of time. Bad user input
that should return informative errors will probably return 500s.

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
deployed [Heroku Instance](https://hargh.herokuapp.com)

Alternative if you prefer [Postman](https://getpostman.com), you can
import the collection of endpoints from [here](Hargh.postman_collection.json).

## Loading HAR files

There is a little helper script to load HARs from the command line
called `load_har`.

Download a HAR and call `./load_har '<path_to_har>''`

# License

This project is licensed under the [MIT License](./LICENSE.md)
