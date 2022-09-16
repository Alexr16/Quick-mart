module Validation
  def validate_option(option, function) # rubocop:disable all
    case function
    when 'main_menu'
      while option != '1' && option != '2'
        puts 'Please enter a valid option: '
        option = gets.chomp
      end
      option
    when 'menu'
      while option != '1' && option != '2' && option != '3' && option != '4' && option != '5'
        puts 'Please enter a valid option: '
        option = gets.chomp
      end
      option
    end
  end

  def validate_item_selection(item, inventory) # rubocop:disable all
    while item.negative? || item > inventory.length - 1 || inventory[item].quantity.zero?
      puts 'Please enter a valid option: ' if item.negative? || item > inventory.length - 1
      puts 'Item is out of stock' if inventory[item]&.quantity&.zero?
      puts 'Select an item: '
      item = gets.chomp.to_i
    end
    item
  end

  def validate_item_quantity(quantity, item)
    while quantity > item.quantity || quantity <= 0
      puts 'Not enough items in stock' if quantity > item.quantity
      puts 'Please enter a valid quantity' if quantity <= 0
      puts 'Enter item quantity: '
      quantity = gets.chomp.to_i
    end
    quantity
  end

  def validate_item_name(item, inventory) # rubocop:disable all
    while !item || item.quantity.zero?
      puts 'Item not found' unless item
      puts 'Item is out of stock' if item&.quantity&.zero?
      puts 'Enter item name: '
      name = gets.chomp
      item = inventory.find { |object| object.name == name }
    end
    item
  end

  def validation_remove_item(item, cart)
    while item.negative? || item > cart.length - 1
      puts 'Please enter a valid option: '
      item = gets.chomp.to_i
    end
    item
  end

  def validate_cash(cash, total)
    while cash < total
      puts 'Not enough cash'
      puts 'CASH: '
      cash = gets.chomp.to_f
    end
    cash
  end
end
