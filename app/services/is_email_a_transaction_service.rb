class IsEmailATransactionService
    def initialize(email)
        @email = email
    end

    def call
        prompt =
            <<~PROMPT
                Indica si este correo electrónico de banco es un pago, transferencia de dinero o salida de dinero, respondiendo únicamente verdadero o falso. Contenido del email:
                #{@email.body}
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
        # puts message

        message.downcase.include?("verdadero") ? true : false
    end
end
