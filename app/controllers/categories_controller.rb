class CategoriesController < ApplicationController
    before_action :set_category, only: %i[ update ]
    skip_before_action :verify_authenticity_token, only: [ :update ]

    def index
        @categories = current_user.categories.order(name: :desc)

        @budget = current_user.categories.sum(:budget).round
        if current_user.monthly_income.present? && current_user.monthly_income.positive?
            @savings = (
                (current_user.monthly_income - @budget) / current_user.monthly_income.to_f * 100
            ).round
        else
            @savings = 0
        end

        @essential_categories = current_user.categories.where(type_of_expense: :essential).sum(:budget).round

        if current_user.monthly_income.present? && current_user.monthly_income.positive?
            @essential_percent = (
                @essential_categories / current_user.monthly_income.to_f * 100
            ).round
        else
            @essential_percent = 0
        end

        @optional_categories = current_user.categories.where(type_of_expense: :optional).sum(:budget).round

        if current_user.monthly_income.present? && current_user.monthly_income.positive?
            @optional_percent = (
                @optional_categories / current_user.monthly_income.to_f * 100
            ).round
        else
            @optional_percent = 0
        end
    end

    def update_monthly_income
        # binding.pry
        if current_user.update(user_params)
            redirect_to categories_path, notice: "Se actualizó el ingreso mensual con éxito"
        else
            render :index, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /categories/1 or /categories/1.json
    def update
        if @category.update(category_params)
            respond_to do |format|
                format.html { redirect_to categories_path, notice: "La categoría fue actualizada con éxito." }
                format.json { render json: @category.id, status: :ok }
            end
        else
            respond_to do |format|
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @transaction.errors, status: :unprocessable_entity }
            end
        end
    end

    private

    def set_category
        @category = Category.find(params.expect(:id))
    end

    def category_params
        params.require(:category).permit(:name, :budget, :type_of_expense)
    end

    def user_params
        params.require(:user).permit(:monthly_income)
    end
end
