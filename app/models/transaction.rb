class Transaction < ApplicationRecord
    enum currency: { usd: 0, pen: 1 }

    belongs_to :email
end
