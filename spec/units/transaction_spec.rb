require 'transaction'

describe Transaction do
  it 'raises an error if given an amount with > 2 decimal places' do
    expect{ Transaction.new(type: :credit, amount: 43.126, datetime: Time.now) }.to raise_error("Invalid amount, can't have more than 2 decimal places")
  end

  it 'raises an error if given amount is not a number' do
    expect{ Transaction.new(type: :debit, amount: 'text', datetime: Time.now) }.to raise_error("Invalid amount, must be a number")
  end

  it 'raises an error if given amount is <= 0' do
    expect{ Transaction.new(type: :credit, amount: -3, datetime: Time.now) }.to raise_error("Invalid amount, must be greater than 0")
  end

  it 'raises an error if specified date is in the future' do
    expect{ Transaction.new(type: :credit, amount: 300, datetime: Date.tomorrow) }.to raise_error("Invalid date, cannot be in the future")
  end
end