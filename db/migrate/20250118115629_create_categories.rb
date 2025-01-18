class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.timestamps

      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :budget
    end
  end
end
