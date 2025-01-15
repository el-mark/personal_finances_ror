class Users::SessionsController < Devise::SessionsController
    layout 'sign_in', only: :new

    def new
        # Custom behavior for the sign-in form
        super # Call the original Devise implementation if needed
    end
end
