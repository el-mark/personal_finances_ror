class Transaction < ApplicationRecord
    enum :currency, [ :no_currency, :usd, :pen ]
    enum :frequency, [ :common, :rare ]
    enum :category, [ :other_category, :supermarket, :transference, :health, :investment, :entertainment, :hogar ]

    belongs_to :email, optional: true
    belongs_to :user
end
