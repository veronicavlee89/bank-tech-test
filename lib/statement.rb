class Statement
  attr_reader :text

  def initialize(transactions)
    @text = ""
    @text += "date || credit || debit || balance\n"
    running_balance = 0
    formatted_transactions = []
    transactions.each do |transaction|
      running_balance += transaction.amount
      formatted_transactions << "#{format_date(transaction.datetime)} || #{format_amount(transaction.amount)} || || #{format_amount(running_balance)}\n"
    end
    @text += formatted_transactions.reverse.join
  end

  private

  def format_amount(amount)
    '%.2f' % amount
  end

  def format_date(date)
    date.strftime("%d/%m/%Y")
  end
end