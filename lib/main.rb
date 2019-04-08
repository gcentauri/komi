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

class Komi
  def initialize(sgf_dir)
    @sgf_dir = sgf_dir
    @users = Repositories::UserRepo.new(DB)
    @games = Repositories::GamesRepo.new(DB)
    @players = Repositories::PlayersRepo.new(DB)

    # TODO: sgf files do not require newlines. refactor to parse by specification
    # NOTE: reading in a single sgf file here to test parsing out the game information
    #       in order to build db records both for the game, and players.
    kisei = File.readlines("#{@sgf_dir}/Kis-1981-1.sgf")
    kisei_record = SGF.parse_game_metadata(kisei)
    # NOTE: @games is a rom-repository.  this is the interface between your application
    #       and the underlying data source.  it can have CRUD 'commands' as well as
    #       functions for returning data structures to use in the application.
    @games.create(kisei_record)

    # Now process the players from the game record, could probably use persisted data to do so
    players_from_sgf = SGF.process_players_jp(kisei_record)
    players_from_sgf.each do |player|
      @players.create(player) unless @players.names.include?(player[:name])
    end

    # Now read through a directory full of games and process them into the DB
    kisei_games = Dir.glob("#{@sgf_dir}/Kis01/*")
    kisei_games.each do |file|
      game_record = SGF.parse_game_metadata(File.readlines(file))
      @games.create(game_record)
      SGF.process_players_jp(game_record).each do |player|
        @players.create(player) unless @players.names.include?(player[:name])
      end
    end
  end

  def all_players
    @players.all
  end
end

