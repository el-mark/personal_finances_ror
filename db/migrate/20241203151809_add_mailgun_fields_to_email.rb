class AddMailgunFieldsToEmail < ActiveRecord::Migration[8.0]
  def change
    add_column :emails, :raw_message, :text
    add_column :emails, :domain, :string
    add_column :emails, :recipient, :string
    add_column :emails, :sender, :string
    add_column :emails, :subject, :string
  end
end
