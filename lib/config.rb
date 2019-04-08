db_config = ROM::Configuration.new(:sql, 'sqlite::memory') do |conf|
  conf.default.create_table(:users) do
    primary_key :id
    column :name, String, null: false
    column :email, String, null: false
    column :rank, String
  end

  conf.default.create_table(:players) do
    primary_key :id
    column :name, String, null: false
    column :rank, String
    column :country, String
  end

  conf.default.create_table(:games) do
    primary_key :id
    column :event, String
    column :round, Integer
    column :player_black, String
    column :black_rank, String
    column :player_white, String
    column :white_rank, String
    column :time, String
    column :komi, Float
    column :result, String
    column :date, String
    column :sgf, String
  end
end

db_config.register_relation(Relations::Users)
db_config.register_relation(Relations::Games)
db_config.register_relation(Relations::Players)

DB = ROM.container(db_config)
