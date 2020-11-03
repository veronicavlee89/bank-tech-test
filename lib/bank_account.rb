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
    validate_amount(amount)
    @transactions << @transaction_class.new(type: :credit, amount: amount, datetime: Time.now)
    @transactions.last
  end

  def withdraw(amount)
    validate_amount(amount)
    @transactions << @transaction_class.new(type: :debit, amount: amount, datetime: Time.now)
    @transactions.last
  end

  def print_statement(transactions: @transactions, statement_class: Statement)
    statement = statement_class.new(transactions)
    statement.print
  end

  private

  def validate_amount(amount)
    raise "Invalid amount, must be a number" unless is_a_number?(amount)
    raise "Invalid amount, must be greater than 0" unless is_greater_than_zero?(amount)
    raise "Invalid amount, can't have more than 2 decimal places" if has_over_two_decimals?(amount)
  end

  def is_a_number?(amount)
    amount.is_a?(Integer) || amount.is_a?(Float)
  end

  def is_greater_than_zero?(amount)
    amount > 0
  end

  def has_over_two_decimals?(amount)
    amount.is_a?(Float) && amount.to_s.split('.').last.size > 2
  end
end