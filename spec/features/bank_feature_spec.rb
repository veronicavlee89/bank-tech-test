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

  it 'prints a statement with multiple deposits and withdrawals' do
    account = BankAccount.new
    allow(Time).to receive(:now).and_return(Time.parse("2012-01-10 10:50:15"))
    account.deposit(1000)
    allow(Time).to receive(:now).and_return(Time.parse("2012-01-13 12:25:15"))
    account.deposit(2000)
    allow(Time).to receive(:now).and_return(Time.parse("2012-01-14 12:25:15"))
    account.withdraw(500)
    expect{ account.print_statement }.to output(
                                           "date || credit || debit || balance\n" +
                                             "14/01/2012 || || 500.00 || 2500.00\n" +
                                             "13/01/2012 || 2000.00 || || 3000.00\n" +
                                             "10/01/2012 || 1000.00 || || 1000.00\n"
                                         ).to_stdout
  end

  it 'prints in reverse chronological order of date time, even when transaction is manually backdated' do
    account = BankAccount.new
    allow(Time).to receive(:now).and_return(Time.parse("2012-01-10 10:50:15"))
    account.deposit(1000)
    allow(Time).to receive(:now).and_return(Time.parse("2012-01-13 12:25:15"))
    account.deposit(2000)
    allow(Time).to receive(:now).and_return(Time.parse("2012-01-14 12:25:15"))
    account.withdraw(500)
    expect{ account.print_statement }.to output(
                                           "date || credit || debit || balance\n" +
                                             "14/01/2012 || || 500.00 || 2500.00\n" +
                                             "13/01/2012 || 2000.00 || || 3000.00\n" +
                                             "10/01/2012 || 1000.00 || || 1000.00\n"
                                         ).to_stdout

    account.deposit(2000, '01/01/2011')

    expect{ account.print_statement }.to output(
                                           "date || credit || debit || balance\n" +
                                             "14/01/2012 || || 500.00 || 4500.00\n" +
                                             "13/01/2012 || 2000.00 || || 5000.00\n" +
                                             "10/01/2012 || 1000.00 || || 3000.00\n" +
                                             "01/01/2011 || 2000.00 || || 2000.00\n"
                                           ).to_stdout
  end
end