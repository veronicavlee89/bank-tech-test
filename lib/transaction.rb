class Transaction

  attr_reader :type, :amount_pence, :datetime

  def initialize(type:, amount:, datetime:)
    validate_amount(amount)
    validate_date(datetime)
    @type = type
    @amount_pence = pence(amount)
    @datetime = datetime
  end

  private
  def validate_amount(amount)
    raise "Invalid amount, must be a number" unless is_a_number?(amount)
    raise "Invalid amount, must be greater than 0" unless is_greater_than_zero?(amount)
    raise "Invalid amount, can't have more than 2 decimal places" if has_over_two_decimals?(amount)
  end

  def validate_date(datetime)
    raise "Invalid date, cannot be in the future" if datetime.to_date > Date.today
  end

  def is_a_number?(amount)
    amount.is_a?(Numeric)
  end

  def is_greater_than_zero?(amount)
    amount > 0
  end

  def has_over_two_decimals?(amount)
    amount.is_a?(Float) && amount.to_s.split('.').last.size > 2
  end

  def pence(amount)
    amount * 100
  end
end
