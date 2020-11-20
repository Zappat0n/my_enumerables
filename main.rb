# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/ModuleLength
# My module Enumerable
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

    arr != to_a ? arr : self
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
    raise LocalJumpError if !block_given? && parameter[0].nil? && parameter[1].nil?

    total = 0
    if block_given?
      parameter = parameter[0]
      my_each_with_index do |value, index|
        param = parameter.nil? ? value : yield(parameter, value)
        total = !index.zero? ? yield(total, value) : param
      end
    elsif parameter[1].nil?
      if parameter[0].is_a? Symbol
        my_each_with_index { |value, index| total = value.send parameter[0], (index.zero? ? value : total) }
      else
        my_each { |value| total = value.send parameter[0], total }
      end
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
