class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy api_update ]
  skip_before_action :verify_authenticity_token, only: [ :api_update ]

  def dashboard
    @user_categories = current_user.categories

    @total_pen = current_user.transactions.where(
        currency: :pen, transaction_date: Date.current.beginning_of_month..
    ).sum(:amount) / 100.to_f
    @total_usd = current_user.transactions.where(
      currency: :usd, transaction_date: Date.current.beginning_of_month..
    ).sum(:amount) / 100.to_f

    @transactions_by_category = Transaction.categories.keys.map do |category|
      sum_mount = current_user.transactions.where(
        currency: :pen, transaction_date: Date.current.beginning_of_month..
      ).where(category: category).sum(:amount) / 100.to_f

      next if sum_mount <= 0

      {
        value: sum_mount,
        name: I18n.t("activerecord.attributes.transaction.categories.#{category}")
      }
    end.compact.sort_by { |transaction| -transaction[:value] }

    @categories = Transaction.categories.keys.map(&:to_s).map do |category|
        I18n.t("activerecord.attributes.transaction.categories.#{category}")
    end

    @budget = current_user.categories.sum(:budget).round
    @spending = spending.round
    @difference = [ @budget - @spending, 0 ].max
    @budget_percentage = ((1 - (@difference / @budget.to_f)) * 100).round

    @common_sum = common_sum
    @rare_sum = rare_sum

    @transactions = current_user.transactions.order(transaction_date: :desc, id: :desc).limit(10)
  end

  # GET /transactions or /transactions.json
  def index
    @transactions = current_user.transactions.order(transaction_date: :desc)
  end

  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = current_user

    if @transaction.save
      redirect_to transactions_path, notice: "La transacción fue creada con éxito."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    if @transaction.update(transaction_params)
      respond_to do |format|
        format.html { redirect_to transactions_path, notice: "La transacción fue actualizada con éxito." }
        format.json { render :show, status: :ok, location: @transaction }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api_update/1
  def api_update
    if @transaction.update(unprotected_transaction_params)
      render json: @transaction.id, status: :ok
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy!

    redirect_to transactions_path, status: :see_other, notice: "El movimiento fue borrado con éxito."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(
        :amount, :transaction_date, :transaction_code, :issuer, :source,
        :destination, :category, :frequency, :description, :currency
      )
    end

    def unprotected_transaction_params
      params.require(:transaction).permit(:category, :frequency)
    end

    def spending
      total_pen = current_user.transactions.where(
        currency: :pen, transaction_date: Date.current.beginning_of_month..
      ).sum(:amount) / 100.to_f
      total_usd = current_user.transactions.where(
        currency: :usd, transaction_date: Date.current.beginning_of_month..
      ).sum(:amount) / 100.to_f

      total_usd * 3.78 + total_pen
    end

    def common_sum
      total_pen = current_user.transactions.where(
        currency: :pen, frequency: :common, transaction_date: Date.current.beginning_of_month..
      ).sum(:amount) / 100.to_f
      total_usd = current_user.transactions.where(
        currency: :usd, frequency: :common, transaction_date: Date.current.beginning_of_month..
      ).sum(:amount) / 100.to_f

      total_usd * 3.78 + total_pen
    end

    def rare_sum
      total_pen = current_user.transactions.where(
        currency: :pen, frequency: :rare, transaction_date: Date.current.beginning_of_month..
      ).sum(:amount) / 100.to_f
      total_usd = current_user.transactions.where(
        currency: :usd, frequency: :rare, transaction_date: Date.current.beginning_of_month..
      ).sum(:amount) / 100.to_f

      total_usd * 3.78 + total_pen
    end
end
