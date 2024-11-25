class Transaction < ApplicationRecord
    enum :currency, [ :usd, :pen ]

    belongs_to :email
end
