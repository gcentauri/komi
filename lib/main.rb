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

require_relative 'repositories'

USER_REPO = Repositories::UserRepo.new(DB)
GAMES_REPO = Repositories::GamesRepo.new(DB)

kisei = File.readlines('assets/Kis-1981-1.sgf')

ks = SGF.parse_game_metadata(kisei)

GAMES_REPO.create(ks)

games = Dir.glob( 'assets/Kis01/*')
games.each do |file|
  GAMES_REPO.create(SGF.parse_game_metadata(File.readlines(file)))
end

USER_REPO.create(name: 'Fujisawa Shuko', email: 'shuko@go.ban')
