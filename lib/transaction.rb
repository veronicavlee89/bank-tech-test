class Transaction
  require 'active_support/core_ext/time/calculations'

  attr_reader :type, :amount, :datetime

  def initialize(type:, amount:, datetime:)
    validate_amount(amount)
    validate_date(datetime)
    @type = type
    @amount = amount
    @datetime = datetime
  end

  private
  def validate_amount(amount)
    raise "Invalid amount, must be a number" unless is_a_number?(amount)
    raise "Invalid amount, must be greater than 0" unless is_greater_than_zero?(amount)
    raise "Invalid amount, can't have more than 2 decimal places" if has_over_two_decimals?(amount)
  end

  def validate_date(datetime)
    raise "Invalid date, cannot be in the future" if datetime.to_date.future?
  end

  def is_a_number?(amount)
    amount.is_a?(Integer) || amount.is_a?(Float)
  end

  def is_greater_than_zero?(amount)
    amount > 0
  end

  def has_over_two_decimals?(amount)
    amount.is_a?(Float) && amount.to_s.split('.').last.size > 2
  end
end
