class Transaction < ApplicationRecord
    enum :currency, [ :no_currency, :usd, :pen ]
    enum :frequency, [ :common, :rare ]
    enum :category, [ :food, :transference, :health ]

    belongs_to :email, optional: true
    belongs_to :user
end
