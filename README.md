Kicker app
==========

A wonderful application to allow your team / company determine who plays best.
It features a variation of infamous chess ranking algorythm
[ELO](http://en.wikipedia.org/wiki/Elo_rating_system). The algoythm is changed,
as we are allowing team and single player games.

Find a working installation at: http://kicker.railslove.com/


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
