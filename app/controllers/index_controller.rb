class IndexController < ApplicationController
    before_action :authenticate_user!, except: [ :landing ]

    def landing; end

    def home
        @total_pen = current_user.transactions.where(
            currency: :pen, transaction_date: Date.current.beginning_of_month..
        ).sum(:amount) / 100.to_f
        @total_usd = current_user.transactions.where(
            currency: :usd, transaction_date: Date.current.beginning_of_month..
        ).sum(:amount) / 100.to_f

        @transactions_by_category = current_user.transactions.where(
            currency: :pen, transaction_date: Date.current.beginning_of_month..
        ).group(:category).count

        @categories = Transaction.categories.keys.map(&:to_s).map(&:titleize)
        @category_sums = [1, 2, 3, 4, 3, 2, 0]
    end

    def email_new
        @email = Email.new
    end

    def email_create
        @email = Email.new(email_params)
        if @email.save
            EmailToTransactionService.new(@email, current_user).call
            redirect_to transactions_path, notice: "Se creó el nuevo movimiento a partir de un email"
        else
            render :email_new
        end
    end

    def chatgpt_connection
        user_input = '
            Constancia de Pago Plin
            10 Nov 2024 11:26 AM
            from: Interbank Servicio al Cliente <servicioalcliente@netinterbank.com.pe>
            Código de operación:	01483653
            Cuenta cargo:	Ahorro Sueldo Soles 108 3094799772
            Destinatario:	Samuel Antonio Pezua Espinoza
            Destino:	Plin
            Moneda y monto:	S/ 13.20
        '

        email = Email.create(body: user_input.strip)

        # EmailToTransactionService.new(email).test
        @transaction = EmailToTransactionService.new(email).test
    end

    private

    def email_params
        params.require(:email).permit(:body)
    end

    def authenticate_user!
        # Logic to check if the user is signed in
        redirect_to landing_path unless user_signed_in?
    end
end
