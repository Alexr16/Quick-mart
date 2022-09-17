require_relative 'classes/item'
require_relative 'classes/member'
require_relative 'classes/cart'
require_relative 'modules/load'
require_relative 'modules/validations'
require 'date'

class App # rubocop:disable all
  include Load
  include Validation

  attr_accessor :inventory, :cart, :member, :transaction_number

  def initialize
    @inventory = load_inventory
    @cart = []
    @member = ''
    @transaction_number = load_transaction_number
  end

  def select_costumer_status
    puts 'Select costumer status: '
    puts '1. Reward Member'
    puts '2. Regular Member'
    status = gets.chomp
    status = validate_option(status, 'main_menu')
    case status.to_i
    when 1
      status = 'Reward Member'
    when 2
      status = 'Regular Member'
    end
    @member = Member.new(status)
    puts "Costumer status: #{@member.status}"
  end

  def add_items_to_cart # rubocop:disable all
    puts 'Select an option: '
    puts '1. Choose item from list'
    puts '2. Add item with name'
    option = gets.chomp
    option = validate_option(option, 'main_menu')
    case option.to_i
    when 1
      puts 'Select an item to add to cart: '
      @inventory.each_with_index do |item, index|
        puts "#{index}. #{item.name}" if item.quantity.positive?
      end
      item = gets.chomp.to_i
      item = validate_item_selection(item, @inventory)
      puts 'Enter item quantity: '
      quantity = gets.chomp.to_i
      quantity = validate_item_quantity(quantity, @inventory[item])
      unit_price = unit_price(@inventory[item])
      item_to_cart = Cart.new(@inventory[item], quantity, unit_price)
      @cart << item_to_cart

    when 2
      puts 'Enter item name: '
      name = gets.chomp
      item = @inventory.find { |object| object.name == name }
      item = validate_item_name(item, @inventory)
      puts 'Enter item quantity: '
      quantity = gets.chomp.to_i
      quantity = validate_item_quantity(quantity, item)
      unit_price = unit_price(item)
      item_to_cart = Cart.new(item, quantity, unit_price)
      @cart << item_to_cart
    end
  end

  def remove_item_from_cart
    puts 'Select an option:'
    puts '1. Remove individual item'
    puts '2. Remove all items'
    option = gets.chomp
    option = validate_option(option, 'main_menu')
    case option.to_i
    when 1
      puts 'Select an item to remove from cart: '
      @cart.each_with_index do |item, index|
        puts "#{index}. #{item.name}"
      end
      item = gets.chomp.to_i
      item = validation_remove_item(item, @cart)
      @cart.delete_at(item)
    when 2
      @cart = []
    end
  end

  def view_cart
    puts "ITEM#{' ' * 8}QUANTITY#{' ' * 8}UNIT PRICE#{' ' * 8}TOTAL"
    @cart.each do |item|
      puts "#{item.name}#{' ' * 10}#{item.quantity}#{' ' * 12}$#{format('%.2f',
                                                                        item.unit_price)}#{' ' * 12}$#{format('%.2f',
                                                                                                              item.unit_price * item.quantity)}" # rubocop:disable all
    end
    puts "TOTAL NUMBER OF ITEMS: #{total_number_of_items}"
    puts "SUB-TOTAL: $#{format('%.2f', sub_total)}"
    puts "TAX (6.5%): $#{format('%.2f', tax)}"
    puts "TOTAL: $#{format('%.2f', total_price)}"
  end

  def unit_price(item)
    if @member.status == 'Reward Member'
      item.member_price
    else
      item.regular_price
    end
  end

  def sub_total
    sub_total = 0
    @cart.each do |item|
      sub_total += (item.unit_price * item.quantity)
    end
    sub_total
  end

  def tax
    tax = 0
    @cart.each do |item|
      tax += (item.unit_price * item.quantity) * 0.065 if item.tax_status == 'Taxable'
    end
    tax
  end

  def total_price
    sub_total = sub_total()
    tax = tax()
    sub_total + tax
  end

  def total_number_of_items
    total = 0
    @cart.each do |item|
      total += item.quantity
    end
    total
  end

  def checkout # rubocop:disable all
    @date = Date.today
    puts "TOTAL: $#{format('%.2f', total_price)}"
    puts 'CASH: '
    cash = gets.chomp.to_f
    cash = validate_cash(cash, total_price)
    puts "CHANGE: $#{format('%.2f', cash - total_price)}"
    recipe = File.new("transaction_#{format('%06d', @transaction_number)}_#{@date.strftime('%d%m%Y')}.txt", 'w')
    recipe.puts @date.strftime('%B %d, %Y')
    recipe.puts "TRANSACTION: #{format('%06d', @transaction_number)}"
    recipe.puts "ITEM#{' ' * 8}QUANTITY#{' ' * 8}UNIT PRICE#{' ' * 8}TOTAL"
    @cart.each do |item|
      recipe.puts "#{item.name}#{' ' * 10}#{item.quantity}#{' ' * 12}$#{format('%.2f',
                                                                               item.unit_price)}#{' ' * 12}$#{format(
                                                                                 '%.2f', item.unit_price * item.quantity
                                                                               )}"
    end
    recipe.puts '************************************'
    recipe.puts "TOTAL NUMBER OF ITEMS: #{total_number_of_items}"
    recipe.puts "SUB-TOTAL: $#{format('%.2f', sub_total)}"
    recipe.puts "TAX (6.5%): $#{format('%.2f', tax)}"
    recipe.puts "TOTAL: $#{format('%.2f', total_price)}"
    recipe.puts "CASH: $#{format('%.2f', cash)}"
    recipe.puts "CHANGE: $#{format('%.2f', cash - total_price)}"
    recipe.puts '************************************'
    recipe.puts "YOU SAVED: $#{format('%.2f', reward_discount)}!" if @member.status == 'Reward Member'
    update_inventory
    @cart = []
    @transaction_number += 1
    update_transaction_number
    recipe.close
  end

  def update_inventory
    @cart.each do |item|
      @inventory.each do |object|
        object.quantity -= item.quantity if item.name == object.name
      end
    end
    File.open('./data/inventory.txt', 'w') do |file|
      @inventory.each do |item|
        file.puts "#{item.name}: #{item.quantity}, $#{format('%.2f',
                                                             item.regular_price)}, $#{format('%.2f',
                                                                                             item.member_price)}, #{item.tax_status}" # rubocop:disable all
      end
    end
  end

  def update_transaction_number
    File.open('./data/transaction_number.txt', 'w') do |file|
      file.puts @transaction_number
    end
  end

  def reward_discount
    discount = 0
    @cart.each do |item|
      discount += (item.regular_price - item.unit_price) * item.quantity
    end
    discount
  end

  def cancel_transaction
    @cart = []
  end
end
