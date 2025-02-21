class UserEmailsController < ApplicationController
    before_action :set_user_email, only: %i[ destroy ]

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

    def destroy
        @user_email.destroy!

        redirect_to new_user_email_path, status: :see_other, notice: "El correo fue borrado con éxito."
      end

    private

    def user_email_params
        params.require(:user_email).permit(:address)
    end

    def set_user_email
        @user_email = UserEmail.find(params.expect(:id))
    end
end
