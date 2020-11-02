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
    formatted_transactions = []
    running_balance = 0
    @transactions.each do |transaction|
      running_balance += transaction.amount
      formatted_transactions << "#{format_date(transaction.datetime)} || #{format_amount(transaction.amount)} || || #{format_amount(running_balance)}"
    end
    puts formatted_transactions.reverse
  end

  def format_amount(amount)
    '%.2f' % amount
  end

  def format_date(date)
    date.strftime("%d/%m/%Y")
  end
end