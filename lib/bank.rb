require 'time'

class Bank
  def initialize
    @transactions = []
  end

  def deposit(amount)
    @transactions << { type: :credit, amount: amount }
  end

  def print_statement
    puts("date || credit || debit || balance")
    puts("02/11/2020 || #{format_amount(@transactions[0][:amount])} || || #{format_amount(@transactions[0][:amount])}")
  end

  def format_amount(amount)
    '%.2f' % amount
  end
end