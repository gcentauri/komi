# komi
Go game database exercising dry-rb and rom-rb

## Try It
first install bundler if you don't have it, then `bundle install` to fetch the dependencies

use `bin/console` to load the applicaiton.  Currently, the only real functionality is in the GAMES_REPO.

`GAMES_REPO.white_wins` returns an array of game structs where the white player wins.
`GAMES_REPO.player_wins("Fujisawa Shuko")` returns an array of game structs where one of my favorite players is the winner
