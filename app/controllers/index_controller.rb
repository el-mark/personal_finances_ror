class IndexController < ApplicationController
    def home; end

    def transaction_table
        @transactions = Transaction.all
        puts(@transactions.count)
    end

    def email_form; end
    def chatgpt_connection; end
end
