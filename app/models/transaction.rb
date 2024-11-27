class Transaction < ApplicationRecord
    enum :currency, [ :no_currency, :usd, :pen ]

    belongs_to :email
end
