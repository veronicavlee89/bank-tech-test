require 'bank_account'

describe BankAccount do
  describe '#deposit' do
    it 'creates a credit transaction and stores it in the account transactions' do
      transaction_dbl = double('transaction', type: :credit)
      transaction_class_dbl = double('transaction_class', new: transaction_dbl)
      time_dbl = Time.parse("2020-11-02 12:25:15")
      allow(Time).to receive(:now).and_return(time_dbl)
      account = BankAccount.new(transaction_class: transaction_class_dbl)

      expect(transaction_class_dbl).to receive(:new).once.with({amount: 50, datetime: time_dbl, type: :credit})
      expect{ account.deposit(50) }.to change{ account.transactions.count }.by(1)
    end
  end

  describe '#print_statement' do
    it "creates a statement with the account's transactions and instructs statement to print" do
      transaction_dbl = double('transaction')
      transaction_class_dbl = double('transaction_class', new: transaction_dbl)
      account = BankAccount.new(transaction_class: transaction_class_dbl)
      statement_dbl = double('statement')
      statement_class_dbl = double('statement_class', new: statement_dbl)

      account.deposit(50)

      expect(statement_class_dbl).to receive(:new).once.with([transaction_dbl])
      expect(statement_dbl).to receive(:print).once

      account.print_statement(statement_class: statement_class_dbl)
    end
  end
end
