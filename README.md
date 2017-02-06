# Find a Home

The Find a Home project is an effort by a group within Code for San Jose to provide mobile and web applications that make finding affordable housing in the Bay Area easy and fun to do.

## Why

The California Bay Area is currently going through a housing epidemic; rapidly increasing demand for housing is outpacing supply, which is leading to a massive increase in housing costs. To help alleviate the burden of this effect, the Santa Clara county restricts rent growth and has land owners set aside rent controlled housing for those who make under the median income of the area.

While this is good and all, finding that selection of housing is somewhat difficult. While the rest of the housing market is benefited by fancy webapps like Zillow, Padmapper, etc., the rent controlled units are shuffled into a Government contracted website (SocialServe) that is not really well known and hard to use.

Since fancy webapps like Zillow and Padmapper lack rent controlled listings and Social Serve is not on par with with said fancy webapps, Find a Home's goal is to provide a web and mobile application that serves the community while being really, really good looking.

## Tech

Both the mobile and web applications will be powered by a Rails based API that includes rental listings in the area, with the initial listings are crawled from the Social Serve website. The API conforms to the JSON:API standard and will use Swagger to both document the API and generate SDKs for various languages.

The frontend will all be Ember.js served through Caddyserver.

The [mobile application](https://github.com/codeforsanjose/findahomeMobile) is being built using React Native.

## How you can help

I'll update this repo with a CONTRIBUTING.md sometime... soon.

---
