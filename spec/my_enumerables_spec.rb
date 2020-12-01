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
describe '#my_each_with_index' do
  context 'Calls block with two arguments, the item and its index, for each item in enum.' do
    it 'returns an Array when the Object is an Array and there is a Block' do
      arr = []
      [1, 2, 3, 4, 5].my_each_with_index { |x, _index| arr << x + 1 }
      expect(arr).to eq([2, 3, 4, 5, 6])
    end
    it 'returns an Enumerator when the Object is an Array and there is no Block' do
      expect([1, 2, 3, 4, 5].my_each_with_index).to be_an Enumerator
    end
    it 'returns an Array when the Object is a Range and there is a Block' do
      arr = []
      (1..4).my_each_with_index { |x, index| arr << x + index }
      expect(arr).to eq([1, 3, 5, 7])
    end
    it 'returns an Enumerator when the Object is a Range and there is no Block' do
      expect((1..5).my_each_with_index).to be_an Enumerator
    end
  end
end
describe '#my_select(parameter = nil)' do
  context 'selects elements that match a condition' do
    it 'returns an Array when the Object is an Array and there is a Block' do
      expect(%w[a b c d e].my_select { |x| x =~ /[cd]/ }).to eq(%w[c d])
    end
    it 'returns an Enumerator when the Object is an Array and there is no Block' do
      expect([1, 2, 3, 4, 5].my_select).to be_an Enumerator
    end
    it 'returns an Enumerator when the Object is an Array and there is no Block' do
      expect([1, 2, 3, 4, 5].my_select(&:even?)).to eq([2, 4])
    end
  end
end
New
7:42
rspec_testing
