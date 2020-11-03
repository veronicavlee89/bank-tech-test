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
      running_balance += is_credit?(transaction) ? transaction.amount : -transaction.amount
      format_transaction(transaction, running_balance)
    end
    @rows << formatted_transactions.reverse
  end

  def format_transaction(transaction, running_balance)
    "#{format_date(transaction.datetime)} || " +
      "#{format_amount(transaction.amount) + " " if is_credit?(transaction)}|| " +
      "#{format_amount(transaction.amount) + " " if is_debit?(transaction)}|| " +
      "#{format_amount(running_balance)}"
  end

  def is_credit?(transaction)
    transaction.type == :credit
  end

  def is_debit?(transaction)
    transaction.type == :debit
  end

  def format_amount(amount)
    '%.2f' % amount
  end

  def format_date(date)
    date.strftime("%d/%m/%Y")
  end
end