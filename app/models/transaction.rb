class Transaction < ApplicationRecord
    enum currency: { usd: 0, pen: 1 }
end
