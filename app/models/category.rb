class Category < ApplicationRecord
    enum :type_of_expense, [ :essential, :optional ]

    belongs_to :user
    has_many :transactions
end
