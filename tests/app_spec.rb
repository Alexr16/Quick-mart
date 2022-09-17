require_relative '../app'

describe App do
  context 'when testing app initialization' do
    before :each do
      @app = App.new
    end

    it 'should return an instance of app' do
      expect(@app).to be_instance_of(App)
    end

    it 'should return the inventory length' do
      expect(@app.inventory.length).to eq 3
    end

    it 'should return an empty cart length' do
      expect(@app.cart.length).to eq 0
    end

    it 'should return an empty member status' do
      expect(@app.member).to eq ''
    end

    it 'should return the number of transactions' do
      file = File.readlines('./data/transaction_number.txt')
      @transaction_number = file[0].to_i
      expect(@app.transaction_number).to eq @transaction_number
    end

    it 'When select costumer status as "Reward Member" should return "Reward Member"' do
      allow(@app).to receive(:gets).and_return('1')
      @app.select_costumer_status
      expect(@app.member.status).to eq 'Reward Member'
    end
  end

  context 'when testing select_costumer_status and add_item_to_cart options' do
    before :each do
      @app = App.new
      @app.member = Member.new('Reward Member')
    end

    it 'when add items to cart as "Choose item from list" should return "Select an item to add to cart:"' do
      allow(@app).to receive(:gets).and_return('1', '1')
      @app.add_items_to_cart
      expect(@app.cart.length).to eq 1
    end

    it 'when add items to cart as "Add item with name" should return "Enter item name:"' do
      allow(@app).to receive(:gets).and_return('2', 'Red Bull', '1')
      @app.add_items_to_cart
      expect(@app.cart.length).to eq 1
    end

    it 'when add items to cart as "Add item with name" should return "Enter item quantity:"' do
      allow(@app).to receive(:gets).and_return('2', 'Milk', '1')
      @app.add_items_to_cart
      expect(@app.cart.length).to eq 1
    end

    it 'when add items to cart, cart should return the number of items' do
      allow(@app).to receive(:gets).and_return('2', 'Milk', '1')
      @app.add_items_to_cart
      expect(@app.cart[0].quantity).to eq 1
    end
  end

  context 'when testing remove_item and view_cart options' do
    before :each do
      @app = App.new
      @app.member = Member.new('Reward Member')
    end

    it 'when select remove individual item from cart should return an empty cart"' do
      allow(@app).to receive(:gets).and_return('2', 'Milk', '1', '1')
      @app.add_items_to_cart
      allow(@app).to receive(:gets).and_return('1', '0')
      @app.remove_item_from_cart
      expect(@app.cart.length).to eq 0
    end

    it 'when select remove all items from cart should return an empty cart"' do
      allow(@app).to receive(:gets).and_return('2', 'Milk', '1', '1')
      @app.add_items_to_cart
      allow(@app).to receive(:gets).and_return('2')
      @app.remove_item_from_cart
      expect(@app.cart.length).to eq 0
    end

    it 'when select view cart should return the transaction info"' do
      allow(@app).to receive(:gets).and_return('2', 'Milk', '1', '1')
      @app.add_items_to_cart
      allow(@app).to receive(:gets).and_return('3')
      expect do
        @app.view_cart
      end.to output("ITEM#{' ' * 8}QUANTITY#{' ' * 8}UNIT PRICE#{' ' * 8}TOTAL\nMilk#{' ' * 10}1#{' ' * 12}$3.50#{' ' * 12}$3.50\nTOTAL NUMBER OF ITEMS: 1\nSUB-TOTAL: $3.50\nTAX (6.5%): $0.00\nTOTAL: $3.50\n").to_stdout # rubocop:disable all
    end
  end

  context 'when testing mathematical operations' do
    before :each do
      @app = App.new
      @item1 = Item.new('Milk', 10, 3.75, 3.50, 'Tax-Exempt')
      @app.member = Member.new('Reward Member')
      @app.cart.push(Cart.new(@item1, 1, 3.50))
    end

    it 'when unite price function is called should return the unit price of the item' do
      expect(@app.unit_price(@item1)).to eq 3.50
    end

    it 'when sub_total function is called should return the sub total of the cart' do
      expect(@app.sub_total).to eq 3.50
    end

    it 'when tax function is called should return the tax of the cart' do
      expect(@app.tax).to eq 0.00
    end

    it 'when total_price function is called should return the total of the cart' do
      expect(@app.total_price).to eq 3.50
    end

    it 'when total_number_ofitems function is called should return the total number of items in the cart' do
      expect(@app.total_number_of_items).to eq 1
    end

    it 'when regard_discount function is called should return the discount' do
      expect(@app.reward_discount).to eq 0.25
    end
  end

  context 'when testing checkout and cancel_transaction options' do
    before :each do
      @app = App.new
      @app.member = Member.new('Reward Member')
    end

    it 'when select checkout should update the inventory' do
      @milk = @app.inventory[0].quantity
      allow(@app).to receive(:gets).and_return('2', 'Milk', '1', '1')
      @app.add_items_to_cart
      allow(@app).to receive(:gets).and_return('4')
      @app.checkout
      expect(@app.inventory[0].quantity).to eq @milk - 1
    end

    it 'when update_transaction function is called should update the transaction number' do
      file = File.readlines('./data/transaction_number.txt')
      @transaction_number = file[0].to_i
      allow(@app).to receive(:gets).and_return('2', 'Milk', '1', '1')
      @app.add_items_to_cart
      allow(@app).to receive(:gets).and_return('4')
      @app.checkout
      expect(@app.transaction_number).to eq @transaction_number + 1
    end

    it 'when cancel_transaction function is called should return an empty cart' do
      allow(@app).to receive(:gets).and_return('2', 'Milk', '1', '1')
      @app.add_items_to_cart
      allow(@app).to receive(:gets).and_return('5')
      @app.cancel_transaction
      expect(@app.cart.length).to eq 0
    end
  end
end
