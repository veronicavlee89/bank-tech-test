require 'bank'

describe Bank do
  describe '#print_statement' do
    it 'creates a statement with the given transactions and prints it to the console' do
      bank = Bank.new
      statement_dbl = double('statement', text: "date || credit || debit || balance\n02/11/2020 || 50.00 || || 50.00\n")
      statement_class_dbl = double('statement_class', new: statement_dbl)
      transactions_dbl = ['transaction double']

      expect(statement_class_dbl).to receive(:new).once.with(transactions_dbl)
      expect{ bank.print_statement(transactions: transactions_dbl, statement_class: statement_class_dbl) }.to output("date || credit || debit || balance\n02/11/2020 || 50.00 || || 50.00\n").to_stdout
    end
  end
end
