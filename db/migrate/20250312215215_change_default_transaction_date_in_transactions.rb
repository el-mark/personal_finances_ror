class ChangeDefaultTransactionDateInTransactions < ActiveRecord::Migration[8.0]
  def change
    change_column_default :transactions, :transaction_date, from: "2024-11-25", to: nil
  end
end
