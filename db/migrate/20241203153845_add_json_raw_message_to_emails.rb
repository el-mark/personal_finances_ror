class AddJsonRawMessageToEmails < ActiveRecord::Migration[8.0]
  def change
    add_column :emails, :json_raw_message, :json
  end
end
