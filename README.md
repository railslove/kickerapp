You look great in Suspenders
============================

Use the following guides for getting things done, programming well, and
programming in style.

* [Protocol](http://github.com/thoughtbot/guides/blob/master/protocol)
* [Best Practices](http://github.com/thoughtbot/guides/blob/master/best-practices)
* [Style](http://github.com/thoughtbot/guides/blob/master/style)


Setup development
-----------------

In order to get a local copy of production data, create a heroku db backup and
import it into your local database:

    # Create a new backuo
    heroku pgbackups:capture --app crawlingcounter

    # Download the latest backup
    curl -o latest.dump `heroku pgbackups:url --app crawlingcounter`

    # Restore data. Optionally: Specify user with '-U myuser'
    pg_restore --verbose --clean --no-acl --no-owner -h localhost -d kickerapp_development latest.dump

Restart your rails app and everything should be set.
