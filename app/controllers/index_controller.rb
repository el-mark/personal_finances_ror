class IndexController < ApplicationController
    def landing; end

    def home; end

    def transaction_table
        @transactions = Transaction.all
        puts(@transactions.count)
    end

    def email_new
        @email = Email.new
    end

    def email_create
        @email = Email.new(email_params)
        if @email.save
            EmailToTransactionService.new(@email).call
            redirect_to transaction_table_path, notice: "Email created successfully."
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
        EmailToTransactionService.new(email).call
    end

    private

    def email_params
        params.require(:email).permit(:body)
    end
end
