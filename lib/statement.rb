class Statement

  HEADER = "date || credit || debit || balance"

  def initialize(transactions, date_format: :dd_mm)
    @rows = [HEADER, formatted_transactions(transactions, date_format)]
  end

  def print
    puts @rows.join("\n")
  end

  private

  def formatted_transactions(transactions, date_format)
    transactions.sort_by! { |transaction| transaction.datetime }
    formatted_transactions = transactions.map.with_index do |transaction, index|
      format_transaction(transaction, running_balance(transactions, index), date_format)
    end
    formatted_transactions.reverse
  end

  def running_balance(transactions, index)
    transactions[0..index].reduce(0) { |sum, transaction| sum + signed_amount(transaction) }
  end

  def signed_amount(transaction)
    is_credit?(transaction) ? transaction.amount_pence : -transaction.amount_pence
  end

  def format_transaction(transaction, running_balance, date_format)
    "#{format_date(transaction.datetime, date_format)} || " +
      "#{format_amount(transaction.amount_pence) + " " if is_credit?(transaction)}|| " +
      "#{format_amount(transaction.amount_pence) + " " if is_debit?(transaction)}|| " +
      "#{format_amount(running_balance)}"
  end

  def is_credit?(transaction)
    transaction.type == :credit
  end

  def is_debit?(transaction)
    transaction.type == :debit
  end

  def format_amount(amount_pence)
    '%.2f' % (amount_pence / 100)
  end

  def format_date(date, date_format)
    validate_date_format(date_format)
    return date.strftime("%d/%m/%Y") if date_format == :dd_mm
    date.strftime("%m/%d/%Y") if date_format == :mm_dd
  end

  def validate_date_format(date_format)
    raise "Invalid date format, must be :dd_mm or :mm_dd" unless [:dd_mm, :mm_dd].include?(date_format)
  end
end