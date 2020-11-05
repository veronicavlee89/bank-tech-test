require 'bank_account'

describe BankAccount do

  describe '#deposit' do
    context 'date not specified by user' do
      it 'creates a credit transaction and stores it in the account transactions with the current datetime' do
        transaction_double = double('transaction', type: :credit)
        transaction_class_double = double('transaction_class', new: transaction_double)
        time_double = Time.parse("2020-11-02 12:25:15")
        allow(Time).to receive(:now).and_return(time_double)
        account = BankAccount.new(transaction_class: transaction_class_double)

        expect(transaction_class_double).to receive(:new).once.with({amount: 50, datetime: time_double, type: :credit})
        expect{ account.deposit(50) }.to change{ account.transactions.count }.by(1)
      end
    end

    context 'date specified by user' do
      it 'creates a credit transaction with the given date and stores it in the account transactions' do
        transaction_double = double('transaction', type: :credit)
        transaction_class_double = double('transaction_class', new: transaction_double)
        account = BankAccount.new(transaction_class: transaction_class_double)

        expected_date = Time.parse('01/01/2020')

        expect(transaction_class_double).to receive(:new).once.with({amount: 50, datetime: expected_date, type: :credit})
        expect{ account.deposit(50, '01/01/2020') }.to change{ account.transactions.count }.by(1)
      end
    end
  end

  describe '#withdraw' do
    context 'date not specified by user' do
      it 'creates a debit transaction and stores it in the account transactions with the current datetime' do
        transaction_double = double('transaction', type: :debit)
        transaction_class_double = double('transaction_class', new: transaction_double)
        time_double = Time.parse("2020-11-03 16:01:00")
        allow(Time).to receive(:now).and_return(time_double)
        account = BankAccount.new(transaction_class: transaction_class_double)

        expect(transaction_class_double).to receive(:new).once.with({amount: 50, datetime: time_double, type: :debit})
        expect{ account.withdraw(50) }.to change{ account.transactions.count }.by(1)
      end
    end

    context 'date specified by user' do
      it 'creates a debit transaction with the given date and stores it in the account transactions' do
        transaction_double = double('transaction', type: :credit)
        transaction_class_double = double('transaction_class', new: transaction_double)
        account = BankAccount.new(transaction_class: transaction_class_double)

        expected_date = Time.parse('01/01/2020')

        expect(transaction_class_double).to receive(:new).once.with({amount: 50, datetime: expected_date, type: :debit})
        expect{ account.withdraw(50, '01/01/2020') }.to change{ account.transactions.count }.by(1)
      end
    end
  end

  describe '#print_statement' do

    it "creates a statement with the account's transactions and instructs statement to print" do
      transaction_double = double('transaction')
      transaction_class_double = double('transaction_class', new: transaction_double)
      account = BankAccount.new(transaction_class: transaction_class_double)
      statement_double = double('statement')
      statement_class_double = double('statement_class', new: statement_double)

      account.deposit(50)
      account.withdraw(30)

      expect(statement_class_double).to receive(:new).once.with([transaction_double, transaction_double], date_format: :dd_mm)
      expect(statement_double).to receive(:print).once

      account.print_statement(statement_class: statement_class_double)
    end

    it 'instructs statement to print with date format of :mm_dd if selected by user' do
      transaction_double = double('transaction')
      transaction_class_double = double('transaction_class', new: transaction_double)
      account = BankAccount.new(transaction_class: transaction_class_double)
      statement_double = double('statement', print: 'test')
      statement_class_double = double('statement_class', new: statement_double)

      expect(statement_class_double).to receive(:new).once.with([], date_format: :mm_dd)

      account.print_statement(statement_class: statement_class_double, date_format: :mm_dd)
    end
  end
end
