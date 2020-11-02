require 'time'

class Bank
  def initialize
    @transactions = []
  end

  def deposit(amount)
    @transactions << { type: :credit, amount: amount, datetime: Time.now }
  end

  def print_statement
    puts("date || credit || debit || balance")
    puts("#{format_date(@transactions[0][:datetime])} || #{format_amount(@transactions[0][:amount])} || || #{format_amount(@transactions[0][:amount])}")
  end

  def format_amount(amount)
    '%.2f' % amount
  end

  def format_date(date)
    date.strftime("%d/%m/%Y")
  end
end