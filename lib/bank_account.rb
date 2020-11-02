require 'time'

require_relative './transaction'
require_relative './statement'

class BankAccount
  attr_reader :transactions

  def initialize(transaction_class: Transaction)
    @transaction_class = transaction_class
    @transactions = []
  end

  def deposit(amount)
    raise "Invalid amount, can't have more than 2 decimal places" if amount.to_s.split('.').last.size > 2
    @transactions << @transaction_class.new(type: :credit, amount: amount, datetime: Time.now)
  end

  def print_statement(transactions: @transactions, statement_class: Statement)
    statement = statement_class.new(transactions)
    statement.print
  end
end