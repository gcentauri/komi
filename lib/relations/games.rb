module Relations
  class Games < ROM::Relation[:sql]
    schema(:games, infer: true)
    auto_struct true

    def by_winning_color(color)
      where { result.ilike("%#{color}+%") }
    end

    def by_player(name)
      where(player_black: name).union(where(player_white: name))
    end

    def by_player_wins(name)
      by_winning_color('W')
        .where(player_white: name)
        .union(by_winning_color('B').where(player_black: name))
    end
  end
end
