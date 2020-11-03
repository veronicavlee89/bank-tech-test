require 'bank_account'

describe BankAccount do

  subject(:account) { BankAccount.new }

  describe '#deposit' do
    context 'date not specified by user' do
      it 'creates a credit transaction and stores it in the account transactions with the current datetime' do
        transaction_dbl = double('transaction', type: :credit)
        transaction_class_dbl = double('transaction_class', new: transaction_dbl)
        time_dbl = Time.parse("2020-11-02 12:25:15")
        allow(Time).to receive(:now).and_return(time_dbl)
        account = BankAccount.new(transaction_class: transaction_class_dbl)

        expect(transaction_class_dbl).to receive(:new).once.with({amount: 50, datetime: time_dbl, type: :credit})
        expect{ account.deposit(50) }.to change{ account.transactions.count }.by(1)
      end
    end

    context 'date specified by user' do
      it 'creates a credit transaction with the given date and stores it in the account transactions' do
        transaction_dbl = double('transaction', type: :credit)
        transaction_class_dbl = double('transaction_class', new: transaction_dbl)
        account = BankAccount.new(transaction_class: transaction_class_dbl)

        expected_date = Time.parse('01/01/2020')

        expect(transaction_class_dbl).to receive(:new).once.with({amount: 50, datetime: expected_date, type: :credit})
        expect{ account.deposit(50, '01/01/2020') }.to change{ account.transactions.count }.by(1)
      end
    end
  end

  describe '#withdraw' do
    context 'date not specified by user' do
      it 'creates a debit transaction and stores it in the account transactions with the current datetime' do
        transaction_dbl = double('transaction', type: :debit)
        transaction_class_dbl = double('transaction_class', new: transaction_dbl)
        time_dbl = Time.parse("2020-11-03 16:01:00")
        allow(Time).to receive(:now).and_return(time_dbl)
        account = BankAccount.new(transaction_class: transaction_class_dbl)

        expect(transaction_class_dbl).to receive(:new).once.with({amount: 50, datetime: time_dbl, type: :debit})
        expect{ account.withdraw(50) }.to change{ account.transactions.count }.by(1)
      end
    end

    context 'date specified by user' do
      it 'creates a debit transaction with the given date and stores it in the account transactions' do
        transaction_dbl = double('transaction', type: :credit)
        transaction_class_dbl = double('transaction_class', new: transaction_dbl)
        account = BankAccount.new(transaction_class: transaction_class_dbl)

        expected_date = Time.parse('01/01/2020')

        expect(transaction_class_dbl).to receive(:new).once.with({amount: 50, datetime: expected_date, type: :debit})
        expect{ account.withdraw(50, '01/01/2020') }.to change{ account.transactions.count }.by(1)
      end
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
      account.withdraw(30)

      expect(statement_class_dbl).to receive(:new).once.with([transaction_dbl, transaction_dbl])
      expect(statement_dbl).to receive(:print).once

      account.print_statement(statement_class: statement_class_dbl)
    end
  end
end
