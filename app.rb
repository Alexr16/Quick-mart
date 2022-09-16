require_relative 'classes/item'
require_relative 'classes/member'
require_relative 'classes/cart'
require_relative 'modules/load'
require 'date'

class App
  include Load

  attr_accessor :inventory

  def initialize
    @inventory = load_inventory # array of items
    @cart = [] # array of items
    @member = ''
    @transaction_number = load_transaction_number
  end

  def select_costumer_status
    puts 'Select costumer status: '
    puts '1. Reward Member'
    puts '2. Regular Member'
    status = gets.chomp
    while status != '1' && status != '2'
      puts 'Please enter a valid option: '
      status = gets.chomp
    end
    case status.to_i
    when 1
      status = 'Reward Member'
    when 2
      status = 'Regular Member'
    end
    @member = Member.new(status)
    puts "Costumer status: #{@member.status}"
  end

  def add_items_to_cart
    puts 'Select an option: '
    puts '1. Choose item from list'
    puts '2. Add item with name'
    option = gets.chomp
    while option != '1' && option != '2'
      puts 'Please enter a valid option: '
      option = gets.chomp
    end
    case option.to_i
    when 1
      puts 'Select an item to add to cart: '
      @inventory.each_with_index do |item, index|
        puts "#{index}. #{item.name}" if item.quantity > 0
      end
      item = gets.chomp.to_i  
      while item < 0 || item > @inventory.length - 1 || @inventory[item].quantity == 0
        puts 'Please enter a valid option: ' if item < 0 || item > @inventory.length - 1
        puts 'Item is out of stock' if  @inventory[item] && @inventory[item].quantity == 0
        puts 'Select an item: '
        item = gets.chomp.to_i
      end
      puts 'Enter item quantity: '
      quantity = gets.chomp.to_i
      while quantity > @inventory[item].quantity || quantity <= 0
        puts 'Not enough items in stock' if quantity > @inventory[item].quantity
        puts 'Please enter a valid quantity' if quantity <= 0
        puts 'Enter item quantity: '
        quantity = gets.chomp.to_i
      end
      unit_price = unit_price(@inventory[item])
      item_to_cart = Cart.new(@inventory[item], quantity, unit_price)
      @cart << item_to_cart

    when 2
      puts 'Enter item name: '
      name = gets.chomp
      item = @inventory.find { |object| object.name == name }
      while !item || item.quantity == 0
        puts 'Item not found' if !item
        puts 'Item is out of stock' if item && item.quantity == 0
        puts 'Enter item name: '
        name = gets.chomp
        item = @inventory.find { |object| object.name == name }
      end
      puts 'Enter item quantity: '
      quantity = gets.chomp.to_i
      while quantity > item.quantity || quantity <= 0
        puts 'Not enough items in stock' if quantity > item.quantity
        puts 'Please enter a valid quantity' if quantity <= 0
        puts 'Enter item quantity: '
        quantity = gets.chomp.to_i
      end  
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
    while option != '1' && option != '2'
        puts 'Please enter a valid option: '
        option = gets.chomp
    end
    case option.to_i
    when 1
      puts 'Select an item to remove from cart: '
      @cart.each_with_index do |item, index|
        puts "#{index}. #{item.name}"
      end
      item = gets.chomp
      @cart.delete_at(item.to_i)
    when 2
        @cart = []
    end
  end

  def view_cart
    puts "ITEM#{" "*8}QUANTITY#{" "*8}UNIT PRICE#{" "*8}TOTAL"
    @cart.each do |item|
      puts "#{item.name}#{" "*10}#{item.quantity}#{" "*12}$#{sprintf('%.2f',item.unit_price)}#{" "*12}$#{sprintf('%.2f',item.unit_price * item.quantity)}"
    end
    puts 'TOTAL NUMBER OF ITEMS: ' + tota_number_of_items().to_s
    puts "SUB-TOTAL: $#{sprintf('%.2f',sub_total)}"
    puts "TAX (6.5%): $#{sprintf('%.2f',tax)}"
    puts "TOTAL: $#{sprintf('%.2f',total_price)}"
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
      if item.tax_status == 'Taxable'
        tax += (item.unit_price * item.quantity) * 0.065
      end
    end
    tax
  end

  def total_price
    sub_total = sub_total()
    tax = tax()
    total = sub_total + tax
  end

  def tota_number_of_items
    total = 0
    @cart.each do |item|
      total += item.quantity
    end
    total
  end

  def checkout
    @date = Date.today
    puts 'TOTAL: $' + sprintf('%.2f',total_price).to_s
    puts 'CASH: '
    cash = gets.chomp.to_f
    while cash < total_price
        puts 'Not enough cash'
        puts 'CASH: '
        cash = gets.chomp.to_f
    end
    puts "CHANGE: $#{sprintf('%.2f',cash - total_price)}"
    recipe = File.new("transaction_#{sprintf('%06d',@transaction_number)}_#{@date.strftime('%d%m%Y')}.txt", 'w')
    recipe.puts @date.strftime('%B %d, %Y')
    recipe.puts "TRANSACTION: #{sprintf('%06d',@transaction_number)}"
    recipe.puts "ITEM#{" "*8}QUANTITY#{" "*8}UNIT PRICE#{" "*8}TOTAL"
    @cart.each do |item|
        recipe.puts "#{item.name}#{" "*10}#{item.quantity}#{" "*12}$#{sprintf('%.2f',item.unit_price)}#{" "*12}$#{sprintf('%.2f',item.unit_price * item.quantity)}"
    end
    recipe.puts '************************************'
    recipe.puts "TOTAL NUMBER OF ITEMS: #{tota_number_of_items()}"
    recipe.puts "SUB-TOTAL: $#{sprintf('%.2f',sub_total)}"
    recipe.puts "TAX (6.5%): $#{sprintf('%.2f',tax)}"
    recipe.puts "TOTAL: $#{sprintf('%.2f',total_price)}"
    recipe.puts "CASH: $#{sprintf('%.2f',cash)}"
    recipe.puts "CHANGE: $#{sprintf('%.2f',cash - total_price)}"
    recipe.puts '************************************'
    recipe.puts "YOU SAVED: $#{sprintf('%.2f',reward_discount)}!" if @member.status == 'Reward Member'
    update_inventory()
    @cart = []
    @transaction_number += 1
    update_transaction_number()
    recipe.close
  end

  def update_inventory
    @cart.each do |item|
        @inventory.each do |object|
            if item.name == object.name
                object.quantity -= item.quantity
            end
        end
    end
    File.open('./data/inventory.txt', 'w') do |file|
        @inventory.each do |item|
            file.puts "#{item.name}: #{item.quantity}, $#{sprintf('%.2f',item.regular_price)}, $#{sprintf('%.2f',item.member_price)}, #{item.tax_status}"
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
