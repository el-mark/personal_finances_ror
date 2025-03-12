class Transaction < ApplicationRecord
    enum :currency, [ :no_currency, :usd, :pen ]
    enum :frequency, [ :common, :rare ]
    enum :category, [ :other_category, :supermarket, :transference, :health, :investment, :entertainment, :home, :services, :transport, :pet, :charity, :debts, :delivery, :subscriptions, :clothing, :education, :travel ]

    belongs_to :email, optional: true
    belongs_to :user
    # belongs_to :category
end
