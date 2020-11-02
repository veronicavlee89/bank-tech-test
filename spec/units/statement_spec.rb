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
  it 'returns a statement containing 02/11/2020 || 50.00 || || 50.00 given an account with a credit of 50.00' do
    transaction_dbl = TransactionDouble.new(type: :credit, amount: 50.00, datetime: Time.parse("2020-11-02 10:50:15"))
    # account_dbl = double('account', :transactions => [transaction_dbl])
    expect(Statement.new([transaction_dbl]).text).to eq("date || credit || debit || balance\n02/11/2020 || 50.00 || || 50.00\n")
  end

  # it 'prints a statement containing 01/03/2020 || 500.00 || || 500.00 when a deposit of 500.00 has been made' do
  #   bank = Bank.new
  #   allow(Time).to receive(:now).and_return(Time.parse("2020-03-01 10:50:15"))
  #   bank.deposit(500.00)
  #   expect{ bank.print_statement }.to output("date || credit || debit || balance\n01/03/2020 || 500.00 || || 500.00\n").to_stdout
  # end
  #
  # it 'prints the running balance as at the time of each transaction' do
  #   bank = Bank.new
  #   allow(Time).to receive(:now).and_return(Time.parse("2020-03-01 10:50:15"))
  #   bank.deposit(20.00)
  #   allow(Time).to receive(:now).and_return(Time.parse("2020-11-02 12:25:15"))
  #   bank.deposit(500.00)
  #   expect{ bank.print_statement }.to output(
  #                                       "date || credit || debit || balance\n" +
  #                                         "02/11/2020 || 500.00 || || 520.00\n" +
  #                                         "01/03/2020 || 20.00 || || 20.00\n"
  #                                     ).to_stdout
  # end
end