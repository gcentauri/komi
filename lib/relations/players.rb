module Relations
  class Players < ROM::Relation[:sql]
    schema(:players, infer: true)
    auto_struct true
  end
end
