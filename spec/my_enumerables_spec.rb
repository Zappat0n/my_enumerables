require_relative '../main'

describe Enumerable do
  describe '#my_each' do
    context 'Calls the given block once for each element in self, passing that element as a parameter.' do
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

  describe '#my_all?(parameter = nil)' do
    context 'returns true if all elements match a condition' do
      it 'return is correct when there is a Block and no parameters' do
        expect([1, 3, 5, 9].my_all? { |x| x > 7 }).to eq(false)
      end

      it 'return is correct when there is not a Block and the parameter is a RegEx' do
        expect(%w[a b c d e].my_all?(/[cd]/)).to eq(false)
      end

      it 'return is correct when there is neither a Block nor a parameter' do
        expect([1, 2, 3, 4, 5].my_all?).to eq(true)
      end

      it 'return is correct when there is not a Block and the parameter is an Object' do
        expect([1, 1, 1, 1, 1].my_all?(1)).to eq(true)
      end

      it 'return is correct when there is not a Block and no parameter is a Class' do
        expect([1, 2, 3, 4, 5].my_all?(Integer)).to eq(true)
      end
    end
  end

  describe '#my_any?(parameter = nil)' do
    context 'returns true if any elements match a condition' do
      it 'return is correct when there is a Block and no parameters' do
        expect([1, 3, 5, 9].my_any? { |x| x > 7 }).to eq(true)
      end

      it 'return is correct when there is not a Block and the parameter is a RegEx' do
        expect(%w[a b c d e].my_any?(/[cd]/)).to eq(true)
      end

      it 'return is correct when there is neither a Block nor a parameter' do
        expect([1, 2, 3, 4, 5].my_any?).to eq(true)
      end

      it 'return is correct when there is not a Block and the parameter is an Object' do
        expect([1, 1, 1, 1, 1].my_any?(3)).to eq(false)
      end

      it 'return is correct when there is not a Block and no parameter is a Class' do
        expect([1, 2, 3, 4, 5].my_any?(String)).to eq(false)
      end
    end
  end
  describe '#my_none?(parameter = nil)' do
    context 'Returns true if none of the elements match a condition.' do
      it 'return is correct when there is a Block and no parameters' do
        expect([1, 3, 5, 9].my_none? { |x| x > 7 }).to eq(false)
      end

      it 'return is correct when there is not a Block and the parameter is a RegEx' do
        expect(%w[a b c d e].my_none?(/[gh]/)).to eq(true)
      end

      it 'return is correct when there is neither a Block nor a parameter' do
        expect([1, 2, 3, 4, 5].my_none?).to eq(false)
      end

      it 'return is correct when there is not a Block and the parameter is an Object' do
        expect([1, 1, 1, 1, 1].my_none?(1)).to eq(false)
      end

      it 'return is correct when there is not a Block and the parameter is a Class' do
        expect([1, 2, 3, 4, 5].my_none?(Integer)).to eq(false)
      end
    end
  end

  describe '#my_count(parameter = nil)' do
    context 'Counts all elements that match a condition.' do
      it 'return is corr
    ect when there is a Block and no parameters' do
        expect([1, 3, 5, 9].my_count { |x| x > 7 }).to eq(1)
      end

      it 'return is correct when there is neither a Block nor a parameter' do
        expect([1, 2, 3, 4, 5].my_count).to eq(5)
      end

      it 'return is correct when there is not a Block and the parameter is an Object' do
        expect([1, 2, 2, 4, 5].my_count(2)).to eq(2)
      end

      it 'return is correct when there is not a Block and the parameter is a Proc' do
        pr = proc { |x| x =~ /[cd]/ }
        expect(%w[a b c d e].my_count(pr)).to eq(2)
      end
    end
  end
end
