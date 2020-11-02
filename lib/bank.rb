require 'time'

require_relative './transaction'

class Bank
  def initialize(transaction_class = Transaction)
    @transaction_class = transaction_class
    @transactions = []
  end

  def deposit(amount)
    @transactions << @transaction_class.new(type: :credit, amount: amount, datetime: Time.now)
  end

  def print_statement
    puts("date || credit || debit || balance")
    puts("#{format_date(@transactions[0].datetime)} || #{format_amount(@transactions[0].amount)} || || #{format_amount(@transactions[0].amount)}")
  end

  def format_amount(amount)
    '%.2f' % amount
  end

  def format_date(date)
    date.strftime("%d/%m/%Y")
  end
end