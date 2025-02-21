class AddMonthlyIncomeToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :monthly_income, :integer
  end
end
