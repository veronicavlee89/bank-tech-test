require 'statement'
require 'time'

class TransactionDouble
  attr_reader :type, :amount_pence, :datetime

  def initialize(type:, amount:, datetime:)
    @type = type
    @amount_pence = amount * 100
    @datetime = datetime
  end
end

describe Statement do
  it 'prints a statement containing 02/11/2020 || 50.25 || || 50.25 given a credit transaction of 50.25' do
    transaction_double = TransactionDouble.new(type: :credit, amount: 50.25, datetime: Time.parse("2020-11-02 10:50:15"))
    statement = Statement.new([transaction_double])
    expect{ statement.print }.to output("date || credit || debit || balance\n02/11/2020 || 50.25 || || 50.25\n").to_stdout
  end

  it 'prints a statement containing 02/11/2020 || || 50.25 || -50.25 given a debit transaction of 50.25' do
    transaction_double = TransactionDouble.new(type: :debit, amount: 50.25, datetime: Time.parse("2020-11-02 10:50:15"))
    statement = Statement.new([transaction_double])
    expect{ statement.print }.to output("date || credit || debit || balance\n02/11/2020 || || 50.25 || -50.25\n").to_stdout
  end

  it 'formats amounts with no decimal places to have 2 decimals' do
    transaction_double = TransactionDouble.new(type: :credit, amount: 20, datetime: Time.parse("2020-11-02 10:50:15"))
    statement = Statement.new([transaction_double])
    expect{ statement.print }.to output("date || credit || debit || balance\n02/11/2020 || 20.00 || || 20.00\n").to_stdout
  end

  it 'formats amounts with 1 decimal place to have 2 decimals' do
    transaction_double = TransactionDouble.new(type: :credit, amount: 12.5, datetime: Time.parse("2020-11-02 10:50:15"))
    statement = Statement.new([transaction_double])
    expect{ statement.print }.to output("date || credit || debit || balance\n02/11/2020 || 12.50 || || 12.50\n").to_stdout
  end

  it 'formats one transaction per line with a running balance, in reverse chronological order of datetime' do
    transaction_double_1 = TransactionDouble.new(type: :credit, amount: 20, datetime: Time.parse("2020-10-30 15:22:08"))
    transaction_double_2 = TransactionDouble.new(type: :debit, amount: 12.5, datetime: Time.parse("2020-11-05 10:50:15"))
    transaction_double_3 = TransactionDouble.new(type: :credit, amount: 120.5, datetime: Time.parse("2020-11-03 08:00:15"))
    transactions = [transaction_double_1, transaction_double_2, transaction_double_3]
    statement = Statement.new(transactions)

    expect{ statement.print }.to output(
                                        "date || credit || debit || balance\n" +
                                          "05/11/2020 || || 12.50 || 128.00\n" +
                                          "03/11/2020 || 120.50 || || 140.50\n" +
                                          "30/10/2020 || 20.00 || || 20.00\n"
                                      ).to_stdout
  end

  it 'formats the date in alternate format of mm/dd/yyyy if selected' do
    transaction_double = TransactionDouble.new(type: :credit, amount: 50.25, datetime: Time.parse("2020-11-02 10:50:15"))
    statement = Statement.new([transaction_double], date_format: :mm_dd)
    expect{ statement.print }.to output("date || credit || debit || balance\n11/02/2020 || 50.25 || || 50.25\n").to_stdout
  end

  it 'raises an error if date_format given is not :dd_mm or :mm_dd' do
    transaction_double = TransactionDouble.new(type: :credit, amount: 50.25, datetime: Time.parse("2020-11-02 10:50:15"))
    expect{ Statement.new([transaction_double], date_format: :dd_mm_yyyy) }.to raise_error("Invalid date format, must be :dd_mm or :mm_dd")
  end
end