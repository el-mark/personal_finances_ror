
class TransactionsByCategory
    def initialize(user, category)
        @user = user
        @category = category
    end

    def call
        amount = @user.transactions.where(
            currency: :pen, transaction_date: Date.current.beginning_of_month..
        ).where(category: @category.name).sum(:amount)
        amount / 100.to_f
    end
end
