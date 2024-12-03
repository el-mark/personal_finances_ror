class RemoveFieldsFromEmail < ActiveRecord::Migration[8.0]
  def change
    remove_column :emails, :domain
    remove_column :emails, :raw_message
  end
end
