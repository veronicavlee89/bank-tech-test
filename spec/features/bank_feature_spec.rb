require 'bank_account'

describe 'Feature: Banking' do
  it 'prints a statement containing 01/03/2020 || 500.00 || || 500.00 when a deposit of 500.00 has been made' do
    account = BankAccount.new
    allow(Time).to receive(:now).and_return(Time.parse("2020-03-01 10:50:15"))
    account.deposit(500.00)
    expect{ account.print_statement }.to output(
                                        "date || credit || debit || balance\n" +
                                          "01/03/2020 || 500.00 || || 500.00\n").to_stdout
  end

  it 'prints a statement with multiple deposits and the running balance of each transaction' do
    account = BankAccount.new
    allow(Time).to receive(:now).and_return(Time.parse("2020-03-01 10:50:15"))
    account.deposit(20.00)
    allow(Time).to receive(:now).and_return(Time.parse("2020-11-02 12:25:15"))
    account.deposit(500.00)
    expect{ account.print_statement }.to output(
                                        "date || credit || debit || balance\n" +
                                          "02/11/2020 || 500.00 || || 520.00\n" +
                                          "01/03/2020 || 20.00 || || 20.00\n").to_stdout
  end
end