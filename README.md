# komi
Go game database exercising dry-rb and rom-rb

## Try It
first install bundler if you don't have it, then `bundle install` to fetch the dependencies

use `bin/console` to load the applicaiton.  Currently, theres little to do:

`Games.white_wins` returns an array of game structs where the white player wins.

`Games.player_wins("Fujisawa Shuko")` returns an array of game structs where one of my favorite players is the winner

`Players.names` returns array of all the unique players in this collection

`Players.all` returns array of all Player structs (includes rank and country)

