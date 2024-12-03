class AddUserFieldAndMoreToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_reference :transactions, :user, null: false, foreign_key: true
    add_column :transactions, :category, :integer
    add_column :transactions, :frequency, :integer
    add_column :transactions, :description, :text
  end
end
