require 'statement'
require 'time'

class TransactionDouble
  attr_reader :type, :amount, :datetime

  def initialize(type:, amount:, datetime:)
    @type = type
    @amount = amount
    @datetime = datetime
  end
end

describe Statement do
  it 'prints a statement containing 02/11/2020 || 50.25 || || 50.25 given a credit transaction of 50.25' do
    transaction_dbl = TransactionDouble.new(type: :credit, amount: 50.25, datetime: Time.parse("2020-11-02 10:50:15"))
    statement = Statement.new([transaction_dbl])
    expect{ statement.print }.to output("date || credit || debit || balance\n02/11/2020 || 50.25 || || 50.25\n").to_stdout
  end

  it 'formats amounts with no decimal places to have 2 decimals' do
    transaction_dbl = TransactionDouble.new(type: :credit, amount: 20, datetime: Time.parse("2020-11-02 10:50:15"))
    # account_dbl = double('account', :transactions => [transaction_dbl])
    statement = Statement.new([transaction_dbl])
    expect{ statement.print }.to output("date || credit || debit || balance\n02/11/2020 || 20.00 || || 20.00\n").to_stdout
  end

  it 'formats amounts with 1 decimal place to have 2 decimals' do
    transaction_dbl = TransactionDouble.new(type: :credit, amount: 12.5, datetime: Time.parse("2020-11-02 10:50:15"))
    # account_dbl = double('account', :transactions => [transaction_dbl])
    statement = Statement.new([transaction_dbl])
    expect{ statement.print }.to output("date || credit || debit || balance\n02/11/2020 || 12.50 || || 12.50\n").to_stdout
  end

  it 'formats one transaction per line with a running balance, in reverse chronological order' do
    transaction_dbl_1 = TransactionDouble.new(type: :credit, amount: 20, datetime: Time.parse("2020-10-30 15:22:08"))
    transaction_dbl_2 = TransactionDouble.new(type: :credit, amount: 120.5, datetime: Time.parse("2020-11-02 10:50:15"))
    transactions = [transaction_dbl_1, transaction_dbl_2]
    statement = Statement.new(transactions)

    expect{ statement.print }.to output(
                                        "date || credit || debit || balance\n" +
                                          "02/11/2020 || 120.50 || || 140.50\n" +
                                          "30/10/2020 || 20.00 || || 20.00\n"
                                      ).to_stdout
  end
end