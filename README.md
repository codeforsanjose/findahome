[![Build Status](https://circleci.com/gh/codeforsanjose/findahome.svg?style=shield&circle-token=5a95972fe528dc71c30b62f64f85ba895f260ef8)](https://circleci.com/gh/codeforsanjose/findahome.svg?style=shield&circle-token=5a95972fe528dc71c30b62f64f85ba895f260ef8)
[![Coverage Status](https://coveralls.io/repos/github/codeforsanjose/findahome/badge.svg?branch=development)](https://coveralls.io/github/codeforsanjose/findahome?branch=development)
[![Dependency Status](https://gemnasium.com/badges/github.com/codeforsanjose/findahome.svg)](https://gemnasium.com/github.com/codeforsanjose/findahome)

![screenshot](http://i.imgur.com/XoBiBhE.png)

# Find a Home

The Find a Home project is an effort by a Code for San Jose team to provide mobile and web applications that make finding affordable housing in the Bay Area not only easy but also moderately fun.

## Why

The California Bay Area is currently going through a housing epidemic; rapidly increasing demand for housing is outpacing supply, which is leading to a massive increase in housing costs. To help alleviate the burden of this effect, Bay Area counties restrict rent growth and have land owners set aside rent controlled housing for those who make less than a predetermined amount - with the amount correlating strongly with the median income for the rent controlled area.

Finding affordable housing in the Bay Area is difficult. Cities and counties provide various data on senior, special needs, and family affordable housing. The goal of Find A Home is to consolidate that information and provide a user-friendly web application to navigate and filter nearby affordable housing units.

# Sneak peek

There is a staging server that lives [here](http://199.245.57.129/). Due to the rapid pace of development, it may be broken at any time so keep that in mind - sorry.

## Tech

Both the mobile and web applications will be powered by a Rails based API that serves up rental listings within Santa Clara county, with the initial listings being crawled from the Social Serve website. The API conforms to the JSON:API standard and will use Swagger to both document the API and provide SDK generation for various languages.

The frontend will be in Ember.js.

Both the frontend and backend will be served via Caddyserver with SSL handled by Let's Encrypt.

The [mobile application](https://github.com/codeforsanjose/findahomeMobile) is being built with React Native.

## How you can help

Email [Tyler Hampton](https://github.com/howdoicomputer) or [Yan Yin Choy](https://github.com/ychoy), or message us on Code for San Jose Slack for more information on collaboration.

## How to run this thing

Dependencies:

| Dependency | Version |
|------------|---------|
| Ruby       | v2.3    |
| Node       | v6      |
| Postgres   | v9      |
| Redis      | v3      |

How you install those dependencies depends on your operating system. For Ruby and Node, I highly recommend [rvm](https://rvm.io/) and [nvm](https://github.com/creationix/nvm), respectively. They're both shell based installers for their languages and will allow you to easily switch between installed language versions.

For Postgres and Redis, `brew install` *should* provide you up to date versions for both databases. If you're using Linux, then use your distribution's package manager.

**Steps to start the API and frontend:**

1. Git clone the sucka'
2. `bundle install`
4. `rake ember:install`
5. `bundle exec rails db:setup`
6. `bundle exec rails s`
7. Navigate to `localhost:3000` to see the index.

This will start the app but there won't be any data in it. To get a simple data set run: `rails db:seed`

## Docker

There is a docker-compose.yml file at the root of this project. If you have docker and docker-compose installed and properly setup then getting a working app is relatively easy with a `cp .env.sample .env && docker-compose up`.

## Env

There is `.env.sample` file that contains empty environment variable declarations. This file is pulled into docker containers via docker-compose in an effort to manage secrets without having to check them into a repository.

**Steps to start the listing collection process:**

1. Set an environment variable named `FINDAHOME_USE_PROXIES` to `false`.

The listing collection mechanism is entirely contained within Sidekiq driven jobs. That means that you'll need to have a running instance of Sidekiq.

* Run `bundle exec sidekiq` in another tab while the Rails server is running.
* Run `bundle exec rake search_job:enqueue` to start the listing collection process.

Go to `localhost:3000/sidekiq` to see the listing jobs being processed.

**CAUTION:** Following the above steps may trigger rate limiting by Social Serve. You'll start to see jobs fail in the Sidekiq UI because the fetch listing requests will start to forward to a page that asks a user to enter a captcha in order to prove that they're not a robot. If you enter the captcha then you'll be good to go for another N requests. If you're testing the listing collection code then I encourage you to kill Sidekiq (CTRL+C in the terminal window running it) after five or ten collections.

The requests it sends out are stagged by one minute - i.e, one request per minute - in order to be respectful towards the site maintainers. In order to maintain that respect, try to limit how often you run the listing collection jobs. Hopefully, I'll have data seeding done soon so that all local development doesn't depend on running a few jobs. The listing data will persist in postgres.

Sorry for the setup being so complicated! I plan on making everything easier to install and manage in the future!

Made with :heart: by Code for San Jose
---
