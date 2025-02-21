class ParseOldEmailSenders < ActiveRecord::Migration[8.0]
  def change
    emails = Email.all

    emails.each do |email|
      next unless email.sender.present?

      email.update(sender: email.sender.gsub(/\+[^@]+/, ""))
    end
  end
end
