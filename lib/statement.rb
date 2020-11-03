class Statement

  def initialize(transactions)
    @rows = []
    add_header
    add_transactions(transactions)
  end

  def print
    puts @rows.join("\n")
  end

  private

  def add_header
    @rows << "date || credit || debit || balance"
  end

  def add_transactions(transactions)
    running_balance = 0
    formatted_transactions = transactions.map do |transaction|
      running_balance += transaction.amount
      format_transaction(transaction, running_balance)
    end
    @rows << formatted_transactions.reverse
  end

  def format_transaction(transaction, running_balance)
    "#{format_date(transaction.datetime)} || #{format_amount(transaction.amount)} || || #{format_amount(running_balance)}"
  end

  def format_amount(amount)
    '%.2f' % amount
  end

  def format_date(date)
    date.strftime("%d/%m/%Y")
  end
end