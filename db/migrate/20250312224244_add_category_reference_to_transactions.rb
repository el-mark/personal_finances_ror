class AddCategoryReferenceToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_reference :transactions, :category, foreign_key: true
  end
end
