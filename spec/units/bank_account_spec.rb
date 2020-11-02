require 'bank_account'

describe BankAccount do
  describe '#print_statement' do
    it 'creates a statement with the given transactions and prints statement' do
      account = BankAccount.new
      statement_dbl = double('statement')
      statement_class_dbl = double('statement_class', new: statement_dbl)
      transactions_dbl = ['transaction double']

      expect(statement_class_dbl).to receive(:new).once.with(transactions_dbl)
      expect(statement_dbl).to receive(:print).once

      account.print_statement(transactions: transactions_dbl, statement_class: statement_class_dbl)
    end
  end
end
