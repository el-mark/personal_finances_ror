class CategoriesController < ApplicationController
    before_action :set_category, only: %i[ update ]

    def index
        @categories = current_user.categories
    end

    def update_monthly_income
        # binding.pry
        if current_user.update(user_params)
            redirect_to categories_path, notice: "Se actualizó el ingreso mensual con éxito"
        else
            render :index, status: :unprocessable_entity
        end
    end

    def update
        if @category.update(category_params)
            redirect_to categories_path, notice: "La presupuesto fue actualizado con éxito."
        else
            render :edit, status: :unprocessable_entity
        end
    end

    private

    def set_category
        @category = Category.find(params.expect(:id))
    end

    def category_params
        params.require(:category).permit(:budget)
    end

    def user_params
        params.require(:user).permit(:monthly_income)
    end
end
