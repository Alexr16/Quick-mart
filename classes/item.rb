require 'securerandom'

class Item
  attr_accessor :name, :quantity, :regular_price, :member_price, :tax_status, :inventory

  @@inventory = [] # rubocop:disable Style/ClassVars

  def self.inventory
    @@inventory
  end

  def initialize(name, quantity, regular_price, member_price, tax_status)
    @id = SecureRandom.uuid
    @name = name
    @quantity = quantity
    @regular_price = regular_price
    @member_price = member_price
    @tax_status = tax_status.delete(' ')
    @@inventory << self
  end
end
