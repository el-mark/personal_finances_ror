# rails db:drop db:create db:migrate

# email = Email.create(body: 'hola')

# # Create a new transaction
# transaction = Transaction.create(
#   email: email,
#   transaction_date: Date.today,
#   transaction_code: "TX12345",
#   issuer: "Issuer Name",
#   source: "Source Name",
#   destination: "Destination Name",
#   currency: :pen,
#   amount: 1000
# )


# email = Email.create(body: 'hola')

# # Create a new transaction
# transaction = Transaction.create(
#   email: email,
#   transaction_date: Date.today,
#   transaction_code: "TX12345",
#   issuer: "Issuer Name",
#   source: "Source Name",
#   destination: "Destination Name",
#   currency: 0,
#   amount: 1000
# )


# scraped_email = ScrapedEmail.create(body: 'hola')

# # Create a new transaction
# transaction = EmailTransaction.create(
#   scraped_email: scraped_email,
#   transaction_date: Date.today,
#   amount: 1000
# )



# # Create a new transaction
# transaction = Transaction.create(
#   integer: 100,
#   amount: 1000
# )
# t.references :email
# t.date :transaction_date, default: Date.today
# t.string :transaction_code
# t.string :issuer
# t.string :source
# t.string :destination
# t.integer :currency, null: false
# t.integer :amount, default: 0

# transaction = Transaction.create(
#   email_id: 1,
#   transaction_date: Date.today,
#   transaction_code: "TX12345",
#   issuer: "Issuer Name",
#   source: "Source Name",
#   destination: "Destination Name",
#   currency: 1,
#   amount: 1000
# )