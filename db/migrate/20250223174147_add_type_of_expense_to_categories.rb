class AddTypeOfExpenseToCategories < ActiveRecord::Migration[8.0]
  def change
    add_column :categories, :type_of_expense, :integer
  end
end
