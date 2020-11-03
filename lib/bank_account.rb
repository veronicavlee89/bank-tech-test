require 'time'
require 'active_support/core_ext/time/calculations'

require_relative './transaction'
require_relative './statement'

class BankAccount
  attr_reader :transactions

  def initialize(transaction_class: Transaction)
    @transaction_class = transaction_class
    @transactions = []
  end

  def deposit(amount, date = nil)
    validate_date(date)
    add_transaction(:credit, amount, date)
  end

  def withdraw(amount, date = nil)
    validate_date(date)
    add_transaction(:debit, amount, date)
  end

  def print_statement(transactions: @transactions, statement_class: Statement)
    statement = statement_class.new(transactions)
    statement.print
  end

  private

  def validate_date(date)
    if !date.nil?
      raise "Invalid date, cannot be in the future" if Time.parse(date).future?
    end
  end

  def add_transaction(type, amount, date)
    @transactions << @transaction_class.new(type: type, amount: amount, datetime: datetime(date))
    @transactions.last
  end

  def datetime(date)
    date.nil? ? Time.now : Time.parse(date)
  end
end