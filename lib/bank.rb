require 'time'

require_relative './transaction'
require_relative './statement'

class Bank
  def initialize(transaction_class: Transaction)
    @transaction_class = transaction_class
    @transactions = []
  end

  def deposit(amount)
    @transactions << @transaction_class.new(type: :credit, amount: amount, datetime: Time.now)
  end

  def print_statement(transactions: @transactions, statement_class: Statement)
    statement = statement_class.new(transactions)
    puts statement.text
  end


end