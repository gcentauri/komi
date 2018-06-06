module Repositories
  class GamesRepo < ROM::Repository[:games]
    commands :create

    # collect a list of all game ids
    def ids
      games.pluck(:id)
    end

    def player_collection(name)
      games.by_player(name).to_a
    end

    def black_wins
      games.by_winning_color('B').to_a
    end

    def white_wins
      games.by_winning_color('W').to_a
    end

    def player_wins(name)
      games.by_player_wins(name).to_a
    end
  end
end
