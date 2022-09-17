require_relative 'classes/item'
require_relative 'app'
require_relative 'modules/validations'

class Main
  include Validation
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

  def choose(choice) # rubocop:disable all
    choice = validate_option(choice, 'main_menu')
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
        option = validate_option(option, 'menu')
        case option.to_i
        when 1
          @app.add_items_to_cart
        when 2
          @app.remove_item_from_cart if @app.cart.length.positive? # rubocop:disable all
          puts 'Cart is empty' if @app.cart.length.zero? # rubocop:disable all
        when 3
          @app.view_cart
        when 4
          if @app.cart.length.positive? # rubocop:disable all
            @app.checkout
            puts 'Transaction successful!'
            @checkout = true
          elsif @app.cart.length.zero? # rubocop:disable all
            puts 'Cart is empty'
          end
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
