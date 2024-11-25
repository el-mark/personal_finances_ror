class CreateEmails < ActiveRecord::Migration[8.0]
  def change
    create_table :emails do |t|
      t.timestamps

      t.text :body
    end
  end
end
