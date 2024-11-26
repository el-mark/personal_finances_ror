class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :author
      t.string :title
      t.integer :year

      t.timestamps
    end
  end
end
