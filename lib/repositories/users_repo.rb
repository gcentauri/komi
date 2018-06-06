module Repositories
  class UserRepo < ROM::Repository[:users]
    commands :create

    def query(conditions)
      users.where(conditions)
    end

    # collect a list of all user ids
    def ids
      users.pluck(:id)
    end
  end
end
