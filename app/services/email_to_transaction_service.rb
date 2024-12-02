class EmailToTransactionService
    def initialize(email)
        @email = email
    end

    def call
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
                    moneda: USD,
                    monto: 4400
                }

                - moneda tiene que ser: pen, usd o no_currency.
                - fecha es solo el año, mes y día, mas no la hora.
                return only the json object.
            PROMPT

        client = OpenAI::Client.new


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
        transaction_date = Date.parse(@json_data['fecha'])

        Transaction.create(
            email: @email,
            transaction_date: transaction_date,
            transaction_code: @json_data["codigo_de_operacion"],
            issuer: @json_data["banco"],
            source: @json_data["cuenta_cargo"],
            destination: @json_data["cuenta_destino"],
            currency: @json_data["moneda"].to_sym,
            amount: @json_data["monto"] * 100
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

        Transaction.create(
            email: @email,
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
