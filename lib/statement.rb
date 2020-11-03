class Statement

  def initialize(transactions)
    @rows = []
    @running_balance = 0
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
    transactions.sort_by! { |transaction| transaction.datetime }
    formatted_transactions = transactions.map do |transaction|
      update_balance(transaction)
      format_transaction(transaction)
    end
    @rows << formatted_transactions.reverse
  end

  def update_balance(transaction)
    @running_balance += is_credit?(transaction) ? transaction.amount : -transaction.amount
  end

  def format_transaction(transaction)
    "#{format_date(transaction.datetime)} || " +
      "#{format_amount(transaction.amount) + " " if is_credit?(transaction)}|| " +
      "#{format_amount(transaction.amount) + " " if is_debit?(transaction)}|| " +
      "#{format_amount(@running_balance)}"
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