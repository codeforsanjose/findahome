# Find a Home

The Find a Home project is an effort by a group within Code for San Jose to provide mobile and web applications that make finding affordable housing in the Bay Area not only easy but moderately fun.

## Why

The California Bay Area is currently going through a housing epidemic; rapidly increasing demand for housing is outpacing supply, which is leading to a massive increase in housing costs. To help alleviate the burden of this effect, Bay Area counties restrict rent growth and have rental properties set aside rent controlled housing for those who make under the median income of the area.

While this is good and all, finding that selection of housing is somewhat difficult. While the rest of the housing market is benefited by fancy webapps like Zillow, Padmapper, etc., the rent controlled units are shuffled into a Government contracted website (SocialServe) that is not really well known and hard to use.

Since fancy webapps like Zillow and Padmapper lack rent controlled listings and Social Serve is not on par with with said fancy webapps, Find a Home's goal is to provide a web and mobile application that serves the community while being really, really good looking.

## Tech

Both the mobile and web applications will be powered by a Rails based API that includes rental listings in the area, with the initial listings being crawled from the Social Serve website. The API conforms to the JSON:API standard and will use Swagger to both document the API and provide SDK generation for various languages.

The frontend will be in Ember.js.

Both the frontend and backend will be served via Caddyserver with SSL handled by Let's Encrypt.

The [mobile application](https://github.com/codeforsanjose/findahomeMobile) is being built with React Native.

## How you can help

I'll update this repo with a `CONTRIBUTIONS.md` soon!

## How to run this thing

Dependencies:

| Dependency | Version |
|------------|---------|
| Ruby       | v2.3    |
| Node       | v6      |
| Postgres   | v9      |
| Redis      | v3      |

**Steps to start the API and frontend:**

1. Git clone the sucka'
2. `bundle install`
4. `rake ember:install`
5. `bundle exec rails db:setup`
6. `bundle exec rails s`

This will start the app but there won't be any data in it.

**Steps to start the listing collection process:**

1. Set an environment variable named `FINDAHOME_USE_PROXIES` to `false`.

The listing collection mechanism is entirely contained within Sidekiq driven jobs. That means that you'll need to have a running instance of Sidekiq.

* Run `bundle exec sidekiq` in another tab while the Rails server is running.
* Run `bundle exec rake search_job:enqueue` to start the listing collection process.
* If you navigate to `localhost:3000` in your browser then you should see a simple listing of those, uh, listings.

If you want to have a fancy UI to track jobs, create a `sidekiq.ru` file somewhere outside of the project directory - the `/tmp` directory is a good place.

Then fill that file with this:

```
require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { :size => 1 }
end

require 'sidekiq/web'
run Sidekiq::Web
```

And run `rackup sidekiq.ru` in yet another tab.

**CAUTION:** Following the above steps may trigger rate limiting by Social Serve. You'll start to see jobs fail in the Sidekiq UI because the fetch listing requests will start to forward to a page that asks a user to enter a captcha in order to prove that they're not a robot. If you enter the captcha then you'll be good to go for another N requests. If you're testing the listing collection code then I encourage you to kill Sidekiq (CTRL+C in the terminal window running it) after five or ten collections.

The requests it sends out are stagged by one minute - i.e, one request per minute - in order to be respectful towards the site maintainers. In order to maintain that respect, try to limit how often you run the listing collection jobs. Hopefully, I'll have data seeding done soon so that all local development doesn't depend on running a few jobs. The listing data will persist in postgres.

Sorry for the setup being so complicated! I plan on making everything easier to install and manage in the future!

---
