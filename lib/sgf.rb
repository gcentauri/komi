module SGF
  class << self
    # Parsing sgf details
    # TODO: refactor to parse without newlines!
    # TODO: add parsing a collection
    def meta_field?(str)
      str.match(/^[A-Z]/)
    end

    def pair_meta_field(str)
      tag = tag_to_sym(str[0..1])
      content = str.strip.slice(/\[.*?\]/)[1..-2]
      [tag, content]
    end

    def tag_to_sym(tag)
      case tag
      when 'EV'
        :event
      when 'RO'
        :round
      when 'PB'
        :player_black
      when 'BR'
        :black_rank
      when 'PW'
        :player_white
      when 'WR'
        :white_rank
      when 'TM'
        :time
      when 'KM'
        :komi
      when 'RE'
        :result
      when 'DT'
        :date
      else
        :unknown
      end
    end

    # returns a Hash matching schema for Game records
    def parse_game_metadata(game)
      game.select { |line| meta_field?(line) }
          .map { |field| pair_meta_field(field) }.to_h
    end

    # game_record : Hash<Game>
    # returns Array[<Player>]
    def process_players_jp(game_record)
      [
        { name: game_record[:player_black], rank: game_record[:black_rank], country: 'Japan' },
        { name: game_record[:player_white], rank: game_record[:white_rank], country: 'Japan' }
      ]
    end
  end
end
