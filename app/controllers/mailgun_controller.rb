class MailgunController < ApplicationController
    skip_before_action :verify_authenticity_token

    def forward_email
        email = Email.create(raw_message: params)
        render json: { message: "Email received ok" }, status: :ok
    end
end
