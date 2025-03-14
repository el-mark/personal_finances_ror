class Users::RegistrationsController < Devise::RegistrationsController
    layout 'sign_in', only: :new

    def new
        # Custom logic for the sign-up form
        super
    end

    # def create
    #     build_resource

    #     resource.save
    #     yield resource if block_given?

    #     if resource.persisted?
    #         if resource.active_for_authentication?
    #             set_flash_message! :notice, :signed_up
    #             sign_up(resource_name, resource)
    #             respond_with resource, location: after_sign_up_path_for(resource)
    #         else
    #             set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
    #             expire_data_after_sign_in!
    #             respond_with resource, location: after_inactive_sign_up_path_for(resource)
    #         end
    #     else
    #         clean_up_passwords resource
    #         set_minimum_password_length
    #         respond_with resource
    #     end
    # end

    private

    def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation, :name, :last_name)
    end

    def account_update_params
        params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :name, :last_name)
    end
end
