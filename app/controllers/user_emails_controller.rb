class UserEmailsController < ApplicationController
    def new
        @user_email = UserEmail.new
    end

    def create
        @user_email = UserEmail.new(user_email_params)
        @user_email.user_id = current_user.id

        if @user_email.save
            redirect_to user_emails_path, notice: "El correo fue agregado con éxito."
        else
            render :new, status: :unprocessable_entity
        end
    end

    private

    def user_email_params
        params.require(:user_email).permit(:address)
    end
end
