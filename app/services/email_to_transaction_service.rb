class EmailToTransactionService
    def initialize(email, user)
        @email = email
        @user = user
    end

    def call
        categories = Transaction.categories.keys.join(", ")

        prompt =
            <<~PROMPT
                transform this transaction email text
                #{@email.body}

                into a json object like this:
                {
                    fecha: '2024-12-31',
                    codigo_de_operacion: 12345,
                    banco: 'Interbank',
                    cuenta_cargo: 'Juan Perez',
                    cuenta_destino: '1234567890',
                    categoria: otros,
                    moneda: USD,
                    monto: 4400,
                    descripcion: 'Transferencia a Juan Perez'
                }

                - moneda tiene que ser: pen, usd o no_currency.
                - fecha es solo el año, mes y día, mas no la hora.
                return only the json object.
                - las categorías disponibles: #{categories}
            PROMPT

        client = OpenAI::Client.new
        puts prompt

        response = client.chat(
            parameters: {
                model: "gpt-4o-mini", # Required.
                messages: [ { role: "user", content: prompt } ], # Required.
                temperature: 0.7
            }
        )

        message = response.dig("choices", 0, "message", "content")
        puts message

        parsed_message = message.gsub("```json", "").gsub("```", "")

        @json_data = JSON.parse(parsed_message)

        # transaction_date = Date.parse(@json_data['fecha'])
        transaction_date = Date.parse(@json_data["fecha"])

        # TODO
        other_category_category = @user.categories.find_by(name: "other_category")

        Transaction.create(
            email: @email,
            user: @user,
            transaction_date: transaction_date,
            transaction_code: @json_data["codigo_de_operacion"],
            issuer: @json_data["banco"],
            source: @json_data["cuenta_cargo"],
            destination: @json_data["cuenta_destino"],
            currency: @json_data["moneda"].to_sym,
            amount: @json_data["monto"] * 100,
            frequency: :common,
            category: 0,
            category_id: other_category_category.id,
            description: @json_data["descripcion"]
        )
    end

    def test
        message = '```json
            {
                "fecha": "2024-12-31",
                "codigo_de_operacion": "01483653",
                "banco": "Interbank",
                "cuenta_cargo": "Test Ahorro Sueldo Soles 108 3094799772",
                "cuenta_destino": "Samuel Antonio Pezua Espinoza",
                "moneda": "pen",
                "monto": 15.20
            }
            ```
        '

        parsed_message = message.gsub("```json", "").gsub("```", "")

        @json_data = JSON.parse(parsed_message)

        # transaction_date = Date.parse(@json_data['fecha'])
        transaction_date = Date.parse(@json_data['fecha'])

        transaction = Transaction.create(
            email: @email,
            user: @user,
            transaction_date: transaction_date,
            transaction_code: @json_data["codigo_de_operacion"],
            issuer: @json_data["banco"],
            source: @json_data["cuenta_cargo"],
            destination: @json_data["cuenta_destino"],
            currency: @json_data["moneda"].to_sym,
            amount: @json_data["monto"] * 100
        )
    end
end
