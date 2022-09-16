require_relative '../classes/cart'

describe Cart do
  context 'when testing cart' do
    before :each do
      @item1 = Item.new('Milk', 10, 3.75, 3.50, 'Tax-Exempt')
      @cart_item = Cart.new(@item1, 2, 3.50)
    end

    it 'should return an instance of cart' do
      expect(@cart_item).to be_instance_of(Cart)
    end

    it 'should return the name of the item in the cart' do
      expect(@cart_item.name).to eq 'Milk'
    end

    it 'should return the quantity of the item in the cart' do
      expect(@cart_item.quantity).to eq 2
    end

    it 'should return the unit price of the item in the cart' do
      expect(@cart_item.unit_price).to eq 3.50
    end

    it 'should return the tax status of the item in the cart' do
      expect(@cart_item.tax_status).to eq 'Tax-Exempt'
    end
  end
end
