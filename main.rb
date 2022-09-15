require_relative 'classes/item'
require_relative 'app'

class Main
  def initialize
    @finished = false
    @checkout = false
    @app = App.new
    puts "Welcome to Jerry's Quick Mart!\n\n"
  end

  def menu
    puts 'Please select an option:
    1 - Start transaction
    2 - Exit'
    gets.chomp
  end

  def choose(choice)
    while choice != '1' && choice != '2'
      puts 'Please enter a valid option: '
      choice = gets.chomp
    end

      case choice.to_i
      when 1
        @checkout = false
        @app.select_costumer_status
        until @checkout
        puts 'Select an option:
        1 - Add item to cart
        2 - Remove item from cart
        3 - View cart
        4 - Checkout and Print Receipt
        5 - Cancel transaction'
        option = gets.chomp
        while option != '1' && option != '2' && option != '3' && option != '4' && option != '5'
          puts 'Please enter a valid option: '
          option = gets.chomp
        end
        case option.to_i
        when 1
          @app.add_items_to_cart
        when 2
          @app.remove_item_from_cart
        when 3
          @app.view_cart
        when 4
          @app.checkout
          puts 'Transaction successful!'
          @checkout = true
        when 5
          puts 'Transaction cancelled'
          @app.cancel_transaction
          @checkout = true
        end
        end
      when 2
        @finished = true
      end
  end

  def run
    until @finished
      choice = menu
      choose(choice)
    end
  end
end

Main.new.run
