require_relative '../main'

describe Main do
  describe '#my_each' do
    it 'returns an array when input is an array' do
      arr = []
      [1, 2, 3, 4, 5].my_each { |x| arr << x + 1 }
      expect(arr).to eq([2, 3, 4, 5, 6])
    end

    it 'returns an Enumerator when input is an array and there is no block' do
      expect([1, 2, 3, 4, 5].my_each).to be_an Enumerator
    end

    it 'returns an array when there is a block and input is a range' do
      arr = []
      (1..5).my_each { |x| arr << x + 1 }
      expect(arr).to eq([2, 3, 4, 5, 6])
    end

    it 'returns an Enumerator when input is a range and there is no block' do
      expect((1..5).my_each).to be_an Enumerator
    end
  end
end
