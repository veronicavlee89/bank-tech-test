require 'time'

require_relative './transaction'
require_relative './statement'

class BankAccount
  attr_reader :transactions

  def initialize(transaction_class: Transaction)
    @transaction_class = transaction_class
    @transactions = []
  end

  def deposit(amount, date = nil)
    add_transaction(:credit, amount, date)
  end

  def withdraw(amount, date = nil)
    add_transaction(:debit, amount, date)
  end

  def print_statement(statement_class: Statement, date_format: :dd_mm)
    statement = statement_class.new(@transactions, date_format: date_format)
    statement.print
  end

  private

  def add_transaction(type, amount, date)
    @transactions << @transaction_class.new(type: type, amount: amount, datetime: datetime(date))
    @transactions.last
  end

  def datetime(date)
    date.nil? ? Time.now : Time.parse(date)
  end
end