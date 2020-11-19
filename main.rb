# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/ModuleLength
# My Enumerable implementation
module Enumerable
  # Create #my_each, a method that is identical to #each but (obviously) does not use #each.
  # You'll need to remember the yield statement.
  # Make sure it returns the same thing as #each as well.
  def my_each
    return to_enum unless block_given?

    arr = to_a
    i = 0
    while i < arr.length
      yield(arr[i])
      i += 1
    end
  end

  # Create #my_each_with_index in the same way.
  def my_each_with_index
    return to_enum unless block_given?

    index = 0
    my_each do |value|
      yield(value, index)
      index += 1
    end
  end

  # Create #my_select in the same way, though you may use #my_each in your definition (but not #each).
  def my_select(parameter = nil)
    arr = []
    if block_given?
      my_each { |value| arr.push(value) if yield(value) }
    elsif parameter.nil?
      return Enumerator.new(arr)
    else
      my_each { |value| arr.push(value) if parameter.call(value) }
    end
    arr
  end

  # Create #my_all? (continue as above)
  def my_all?(parameter = nil)
    result = true
    if block_given?
      my_each { |value| return false unless yield(value) }
    else
      case parameter
      when nil
        my_each { |value| return false if value.nil? || !value }
      when Regexp
        my_each { |value| return false unless value =~ parameter }
      when Class
        my_each { |value| return false unless value.is_a? parameter }
      else
        my_each { |value| return false unless value == parameter }
      end
    end
    result
  end

  # Create #my_any?
  def my_any?(parameter = nil)
    result = false
    if block_given?
      my_each { |value| return true if yield(value) }
    else
      case parameter
      when nil
        my_each { |value| return true unless value.nil? || !value }
      when Regexp
        my_each { |value| return true if value =~ parameter }
      when Class
        my_each { |value| return true if value.is_a? parameter }
      else
        my_each { |value| return true if value == parameter }
      end
    end
    result
  end

  # Create #my_none?
  def my_none?(parameter = nil)
    result = true
    if block_given?
      my_each { |value| return false if yield(value) }
    else
      case parameter
      when nil
        my_each { |value| return false unless value.nil? || !value }
      when Regexp
        my_each { |value| return false if value =~ parameter }
      when Class
        my_each { |value| return false if value.is_a? parameter }
      else
        my_each { |value| return false if value == parameter }
      end
    end
    result
  end

  # Create #my_count
  def my_count(parameter = nil)
    count = 0
    if block_given?
      my_each { |value| count += 1 if yield(value) }
    else
      case parameter
      when nil
        my_each { count += 1 }
      when Proc
        my_each { |value| count += 1 if parameter.call(value) }
      else
        my_each { |value| count += 1 if value == parameter }
      end
    end
    count
  end

  # Create #my_inject
  def my_inject(*parameter)
    total = 0
    if block_given?
      parameter = parameter[0]
      my_each_with_index do |value, index|
        if !index.zero?
          total = yield(total, value)
        else
          total = parameter.nil? ? value : yield(parameter, value)
        end
      end
    elsif parameter[1].nil?
      my_each { |value| total = value.send parameter[0], total }
    else
      my_each_with_index { |value, index| total = value.send parameter[1], (index.zero? ? parameter[0] : total) }
    end
    total
  end

  # Modify your #my_map method to take either a proc or a block.
  # It won't be necessary to apply both a proc and a block in the same #my_map call
  # since you could get the same effect by chaining together one #my_map call with the block
  # and one with the proc. This approach is also clearer, since the user doesn't have to remember
  # whether the proc or block will be run first.
  # So if both a proc and a block are given, only execute the proc.
  def my_map(proc = nil)
    return to_enum unless block_given?

    arr = []
    if !proc.nil?
      my_each { |value| arr.push(proc.call(value)) }
    else
      my_each { |value| arr.push(yield(value)) }
    end
    arr
  end
end

# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/ModuleLength

# Test your #my_inject by creating a method called #multiply_els which multiplies all
# the elements of the array together by using #my_inject, e.g. multiply_els([2,4,5]) #=> 40
def multiply_els(arr)
  arr.my_inject(1) { |total, x| total * x }
end

# 1. my_each
puts 'my_each'
puts '-------'
puts [1, 2, 3].my_each { |elem| print "#{elem + 1} " } # => 2 3 4
puts
# 2. my_each_with_index
puts 'my_each_with_index'
puts '------------------'
print [1, 2, 3].my_each_with_index { |elem, idx| puts "#{elem} : #{idx}" } # => 1 : 0, 2 : 1, 3 : 2
puts
# 3. my_select
puts 'my_select'
puts '---------'
p [1, 2, 3, 8].my_select(&:even?) # => [2, 8]
p [0, 2018, 1994, -7].my_select { |n| n > 0 } # => [2018, 1994]
p [6, 11, 13].my_select(&:odd?) # => [11, 13]
puts
# 4. my_all? (example test cases)
puts 'my_all?'
puts '-------'
p [3, 5, 7, 11].my_all?(&:odd?) # => true
p [-8, -9, -6].my_all? { |n| n < 0 } # => true
p [3, 5, 8, 11].my_all?(&:odd?) # => false
p [-8, -9, -6, 0].my_all? { |n| n < 0 } # => false
# test cases required by tse reviewer
p [1, 2, 3, 4, 5].my_all? # => true
p [1, 2, 3].my_all?(Integer) # => true
p %w[dog door rod blade].my_all?(/d/) # => true
p [1, 1, 1].my_all?(1) # => true
puts
# 5. my_any? (example test cases)
puts 'my_any?'
puts '-------'
p [7, 10, 3, 5].my_any?(&:even?) # => true
p [7, 10, 4, 5].my_any?(&:even?) # => true
p %w[q r s i].my_any? { |char| 'aeiou'.include?(char) } # => true
p [7, 11, 3, 5].my_any?(&:even?) # => false
p %w[q r s t].my_any? { |char| 'aeiou'.include?(char) } # => false
# test cases required by tse reviewer
p [3, 5, 4, 11].my_any? # => true
p [1, nil, false].my_any?(1) # => true
p [1, nil, false].my_any?(Integer) # => true
p %w[dog door rod blade].my_any?(/z/) # => false
p [1, 2, 3].my_any?(1) # => true
puts
# 6. my_none? (example test cases)
puts 'my_none?'
puts '--------'
p [3, 5, 7, 11].my_none?(&:even?) # => true
p %w[sushi pizza burrito].my_none? { |word| word[0] == 'a' } # => true
p [3, 5, 4, 7, 11].my_none?(&:even?) # => false
p %w[asparagus sushi pizza apple burrito].my_none? { |word| word[0] == 'a' } # => false
# test cases required by tse reviewer
p [1, 2, 3].my_none? # => false
p [1, 2, 3].my_none?(String) # => true
p [1, 2, 3, 4, 5].my_none?(2) # => false
p [1, 2, 3].my_none?(4) # => true
puts
# 7. my_count (example test cases)
puts 'my_count'
puts '--------'
p [1, 4, 3, 8].my_count(&:even?) # => 2
p %w[DANIEL JIA KRITI dave].my_count { |s| s == s.upcase } # => 3
p %w[daniel jia kriti dave].my_count { |s| s == s.upcase } # => 0
# test cases required by tse reviewer
p [1, 2, 3].my_count # => 3
p [1, 1, 1, 2, 3].my_count(1) # => 3
puts
# 8. my_map
puts 'my_map'
puts '------'
p [1, 2, 3].my_map { |n| 2 * n } # => [2,4,6]
p %w[Hey Jude].my_map { |word| word + '?' } # => ["Hey?", "Jude?"]
p [false, true].my_map(&:!) # => [true, false]
my_proc = proc { |num| num > 10 }
p [18, 22, 5, 6].my_map(my_proc) { |num| num < 10 } # => true true false false
puts
# 9. my_inject
puts 'my_inject'
puts '---------'
p [1, 2, 3, 4].my_inject(10) { |accum, elem| accum + elem } # => 20
p [1, 2, 3, 4].my_inject { |accum, elem| accum + elem } # => 10
p [5, 1, 2].my_inject('+') # => 8
p (5..10).my_inject(2, :*) # should return 302400
p (5..10).my_inject(4) { |prod, n| prod * n } # should return 604800

p (1..5).my_inject(4) { |prod, n| prod * n }#=> 480
p [2, 5, 6].my_inject(:+) #=> 13
