require_relative '../classes/item'

describe Item do
  context 'when testing item' do
    before :each do
      @item1 = Item.new('Milk', 10, 3.75, 3.50, 'Tax-Exempt')
      @item2 = Item.new('Red Bull', 10, 4.50, 4, 'Taxable')
      @item2 = Item.new('Flour', 10, 3.10, 2.75, 'Tax-Exempt')
    end

    it 'should return an istance of item1' do
      expect(@item1).to be_instance_of(Item)
    end

    it 'should return the name of the item1' do
      expect(@item1.name).to eq 'Milk'
    end

    it 'should return the quantity of the item1' do
      expect(@item1.quantity).to eq 10
    end

    it 'should return the regular price of the item1' do
      expect(@item1.regular_price).to eq 3.75
    end

    it 'should return the member price of the item1' do
      expect(@item1.member_price).to eq 3.50
    end

    it 'should return the tax status of the item1' do
      expect(@item1.tax_status).to eq 'Tax-Exempt'
    end

    # it "should return the inventory length" do
    #     expect(Item.inventory.length).to eq 3
    # end
  end
end
