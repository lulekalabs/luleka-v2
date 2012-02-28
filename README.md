# Luleka

The fourth incarnation of a social marketplace for professionals and their 
recommendations developed by Luleka Labs.

## Development Setup

    git clone [this repo]
    cd nl
    gem install bundler (first time)
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

## Heroku

Generate new key:
ssh-keygen -t rsa -C "heroku@luleka.com" -f ~/.ssh/heroku@luleka.com.identity

Upload public key to Heroku:

heroku keys:add ~/.ssh/heroku@luleka.com.identity.pub

Check for other keys and remove:

heroku keys
heroku keys:remove adam@workstation.local

### Managing Heroku account

ssh-add -L # list
ssh-add -D # delete keys if you have to
ssh-add ~/.ssh/heroku@luleka.com.identity
heroku plugins:install git://github.com/ddollar/heroku-accounts.git
heroku accounts:add nl
heroku accounts:set nl

### Heroku Add-ons

*  heroku addons:add custom_domains
*  heroku addons:add custom_domains:wildcard
