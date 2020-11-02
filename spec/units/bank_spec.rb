require 'bank'

describe Bank do
  it 'prints a statement containing 02/11/2020 || 50.00 || || 50.00 when a deposit of 50.00 has been made' do
    bank = Bank.new
    allow(Time).to receive(:now).and_return(Time.parse("2020-11-02 12:25:15"))
    bank.deposit(50.00)
    expect{ bank.print_statement }.to output("date || credit || debit || balance\n02/11/2020 || 50.00 || || 50.00\n").to_stdout
  end

  it 'prints a statement containing 02/11/2020 || 500.00 || || 500.00 when a deposit of 500.00 has been made' do
    bank = Bank.new
    allow(Time).to receive(:now).and_return(Time.parse("2020-11-02 12:25:15"))
    bank.deposit(500.00)
    expect{ bank.print_statement }.to output("date || credit || debit || balance\n02/11/2020 || 500.00 || || 500.00\n").to_stdout
  end

  it 'prints the datetime of the transaction in the format DD/MM/YYYY' do
    bank = Bank.new
    allow(Time).to receive(:now).and_return(Time.parse("2020-03-01 10:50:15"))
    bank.deposit(500.00)
    expect{ bank.print_statement }.to output("date || credit || debit || balance\n01/03/2020 || 500.00 || || 500.00\n").to_stdout
  end

end