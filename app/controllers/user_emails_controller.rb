class UserEmailsController < ApplicationController
    def new
        @user_email = UserEmail.new
    end
end
