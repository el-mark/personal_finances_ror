class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy api_update ]
  skip_before_action :verify_authenticity_token, only: [ :api_update ]

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
end
