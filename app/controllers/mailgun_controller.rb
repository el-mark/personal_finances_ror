class MailgunController < ApplicationController
    skip_before_action :verify_authenticity_token

    def forward_email
        email_params = JSON.parse(params.to_json)
        email = Email.create(raw_message: params, json_raw_message: email_params)
        render json: { message: "Email received ok" }, status: :ok
    end
end
