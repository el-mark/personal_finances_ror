class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.timestamps

      t.references :email
      t.date :transaction_date
      t.string :transaction_code
      t.string :issuer
      t.string :source
      t.string :destination
      t.integer :currency
      t.integer :amount
    end
  end
end
