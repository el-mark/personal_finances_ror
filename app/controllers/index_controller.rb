class IndexController < ApplicationController
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
            redirect_to root_path, notice: "Email created successfully."
        else
            render :email_new
        end
    end

    def chatgpt_connection
        user_input = '
            transform this transaction email text
            "Constancia de Pago Plin
            10 Nov 2024 11:26 AM
            from: Interbank Servicio al Cliente <servicioalcliente@netinterbank.com.pe>
            Código de operación:	01483653
            Cuenta cargo:	Ahorro Sueldo Soles
            108 3094799772
            Destinatario:	Samuel Antonio Pezua Espinoza
            Destino:	Plin
            Moneda y monto:	S/ 13.20"

            into a json object like this:
            {
                fecha: "2024-12-31",
                codigo_de_operacion: 12345,
                banco: "Interbank",
                cuenta_cargo: "Juan Perez",
                cuenta_destino: "1234567890",
                moneda: pen,
                monto: 30
            }

            moneda tiene que ser: pen, usd o no_currency

            return only the json object
        '


        message = '```json
            {
                "fecha": "2024-12-31",
                "codigo_de_operacion": "01483653",
                "banco": "Interbank",
                "cuenta_cargo": "Ahorro Sueldo Soles 108 3094799772",
                "cuenta_destino": "Samuel Antonio Pezua Espinoza",
                "moneda": "pen",
                "monto": 13.20
            }
            ```
        '

        parsed_message = message.gsub("```json", "").gsub("```", "")

        @json_data = JSON.parse(parsed_message)

        # transaction_date = Date.parse(@json_data['fecha'])
        transaction_date = Date.parse(@json_data['fecha'])

        email = Email.create(body: user_input.strip)
        Transaction.create(
            email: email,
            transaction_date: transaction_date,
            transaction_code: @json_data["codigo_de_operacion"],
            issuer: @json_data["banco"],
            source: @json_data["cuenta_cargo"],
            destination: @json_data["cuenta_destino"],
            currency: @json_data["moneda"].to_sym,
            amount: @json_data["monto"]
        )
    end

    private

    def email_params
        params.require(:email).permit(:body)
    end
end
