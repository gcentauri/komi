module Repositories
  class PlayersRepo < ROM::Repository[:players]
    commands :create

    def ids
      players.pluck(:id)
    end

    def names
      players.pluck(:name)
    end

    def all
      players.to_a
    end
  end
end
