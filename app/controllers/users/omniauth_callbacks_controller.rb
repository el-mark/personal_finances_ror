class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
        # You get the auth data from the request
        @user = User.from_omniauth(request.env['omniauth.auth'])

        if @user.persisted?
            sign_in_and_redirect @user, event: :authentication
            set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
        else
            # If the user cannot be saved, redirect back or show an error message
            session['devise.google_data'] = request.env['omniauth.auth'].except(:extra)
            redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
        end
    end
end
