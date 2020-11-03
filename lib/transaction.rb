class Transaction
  attr_reader :type, :amount, :datetime

  def initialize(type:, amount:, datetime:)
    @type = type
    @amount = amount
    @datetime = datetime
  end
end