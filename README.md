# Luleka

The second incarnation of a professional recommendations site developed by Luleka Labs.

## Development Setup

    git clone [this repo]
    cd nl
    bundle install
    rake db:setup

### Notes

We're currently targeting REE (1.8.7) for deployment, but test against
1.9.2 as well.

Email delivery is disabled in development mode to avoid accidentally leaking
confidential information. If you need to see signup emails, to get the links
with confirmation tokens, tail the development log.

## Play with it right now!

The site is currently up and running at:

We deploy several times a day, usually whenever we complete a story.

## Deployment to integration

Deploying should be a simple matter of:

    cap deploy:setup (first time)
    cap deploy

