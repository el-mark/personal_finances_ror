class Users::RegistrationsController < Devise::RegistrationsController
    layout 'sign_in', only: :new

    def new
        # Custom logic for the sign-up form
        super
    end
end
