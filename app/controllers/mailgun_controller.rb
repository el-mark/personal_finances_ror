class MailgunController < ApplicationController
    skip_before_action :verify_authenticity_token

    def forward_email
        email_params = JSON.parse(params.to_json)
        email = Email.create(
            json_raw_message: email_params,
            sender: original_email(email_params["sender"]),
            body: email_params["body-html"],
            recipient: email_params["recipient"],
            subject: email_params["subject"]
        )

        # user = User.find_by(email: original_email(email_params["sender"]))
        user_email = UserEmail.find_by(address: original_email(email_params["sender"]))
        # puts "email_params["sender"]"
        # puts email_params["sender"]
        # puts "user.present?"
        # puts user.present?
        if user_email.present? && IsEmailATransactionService.new(email).call
            EmailToTransactionService.new(email, user_email.user).call
        end

        render json: { message: "Email received ok" }, status: :ok
    end

    private

    def original_email(raw_sender)
        return unless raw_sender.present?

        raw_sender.gsub(/\+[^@]+/, "")
    end
end
