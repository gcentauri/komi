require 'sqlite3'
require 'rom'
require 'rom-sql'
require 'rom-repository'
require 'dry-struct'

require_relative 'relations/users'
require_relative 'relations/players'
require_relative 'relations/games'

require_relative 'config'

require_relative 'sgf'
require_relative 'repositories/users_repo'
require_relative 'repositories/players_repo'
require_relative 'repositories/games_repo'

Users = Repositories::UserRepo.new(DB)
Games = Repositories::GamesRepo.new(DB)
Players = Repositories::PlayersRepo.new(DB)

# TODO: sgf files do not require newlines. refactor to parse by specification
# NOTE: reading in a single sgf file here to test parsing out the game information
#       in order to build db records both for the game, and players.
kisei = File.readlines('assets/Kis-1981-1.sgf')
kisei_record = SGF.parse_game_metadata(kisei)
# NOTE: Games is a rom-repository.  this is the interface between your application
#       and the underlying data source.  it can have CRUD 'commands' as well as
#       functions for returning data structures to use in the application.
Games.create(kisei_record)

# Now process the players from the game record, could probably use persisted data to do so
players = SGF.process_players_jp(kisei_record)
players.each do |player|
  Players.create(player) unless Players.names.include?(player[:name])
end

# Now read through a directory full of games and process them into the DB
games = Dir.glob('assets/Kis01/*')
games.each do |file|
  game_record = SGF.parse_game_metadata(File.readlines(file))
  Games.create(game_record)
  SGF.process_players_jp(game_record).each do |player|
    Players.create(player) unless Players.names.include?(player[:name])
  end
end
