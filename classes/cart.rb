require 'securerandom'

class Cart
  attr_accessor :name, :quantity, :unit_price, :tax_status, :regular_price

  def initialize(item, quantity, unit_price)
    @id = SecureRandom.uuid
    @name = item.name
    @tax_status = item.tax_status
    @unit_price = unit_price
    @regular_price = item.regular_price
    @quantity = quantity
  end
end
