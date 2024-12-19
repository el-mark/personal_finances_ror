class CreateUserEmails < ActiveRecord::Migration[8.0]
  def change
    create_table :user_emails do |t|
      t.timestamps
      t.references :user, null: false, foreign_key: true
      t.string :address
    end
  end
end
