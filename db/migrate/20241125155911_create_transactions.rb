class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.timestamps

      t.references :email
      t.date :transaction_date, default: Date.today
      t.string :transaction_code
      t.string :issuer
      t.string :source
      t.string :destination
      t.integer :currency, :integer, default: 0, null: false
      t.integer :amount, default: 0
    end
  end
end
