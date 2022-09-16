require_relative '../classes/item'

module Load
  def load_inventory
    file = File.readlines('./data/inventory.txt')
    data = file.map do |line|
      line = line.split(',')
      line.map do |item|
        item = item.gsub(/[^-.:0-9A-Za-z ]/, '')
        if item.include?(':')
          item.split(':')
        else
          item
        end
      end
    end

    if file == ''
      @inventory = []
    else
      data.map do |item|
        item = item.flatten(1)
        Item.new(item[0], item[1].to_i, item[2].to_f, item[3].to_f, item[4])
      end
    end
  end

  def load_transaction_number
    file = File.readlines('./data/transaction_number.txt')
    file[0].to_i
  end
end
