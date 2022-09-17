require_relative '../classes/member'

describe Member do
  context 'when testing member' do
    before :each do
      @member1 = Member.new('Reward Member')
      @member2 = Member.new('Regular Member')
    end

    it 'should return an instance of member' do
      expect(@member1).to be_instance_of(Member)
    end

    it 'should return the status of the member1' do
      expect(@member1.status).to eq 'Reward Member'
    end

    it 'should return the status of the member2' do
      expect(@member2.status).to eq 'Regular Member'
    end
  end
end
