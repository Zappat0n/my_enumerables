# My module Enumerable
module Enumerable
  # Create #my_each, a method that is identical to #each but (obviously) does not use #each.
  # You'll need to remember the yield statement.
  # Make sure it returns the same thing as #each as well.
  def my_each
    return 'No block given' unless block_given?

    for value in self do
      yield(value)
    end
  end

  # Create #my_each_with_index in the same way.
  def my_each_with_index
    return 'No block given' unless block_given?

    index = 0
    for value in self do
      yield(value, index)
      index += 1
    end
  end

  # Create #my_select in the same way, though you may use #my_each in your definition (but not #each).
  def my_select
    return 'No block given' unless block_given?

    arr = []
    my_each do |value|
      arr.push(value) if yield(value)
    end
  end

  # Create #my_all? (continue as above)
  def my_all?(parameter)
    #return 'No block given' unless block_given?

    result = true
    my_each do |value|
      if block_given?
        return false unless yield(value)
      else
        if parameter.is_a? Class
          return false unless value.is_a? parameter
        else
          return false unless value =~ parameter
        end
      end
    end
    result
  end

  # Create #my_any?
  def my_any?
    return 'No block given' unless block_given?

    result = false
    my_each do |value|
      return true if yield(value)
    end
    result
  end

  # Create #my_none?
  def my_none?
    return 'No block given' unless block_given?

    result = true
    my_each do |value|
      return false if yield(value)
    end
    result
  end

  # Create #my_count
  def my_count
    count = 0
    my_each do
      count += 1
    end
    count
  end

  # Create #my_map
  def my_map_old
    return 'No block given' unless block_given?

    arr = []
    my_each do |value|
      arr.push(yield(value))
    end
    arr
  end

  # Create #my_inject
  def my_inject(initial = 0)
    return 'No block given' unless block_given?

    total = initial
    my_each do |x|
      total = yield(total, x)
    end
    total
  end

  # Modify your #my_map method to take a proc instead.
  def my_map_proc(proc)
    arr = []
    my_each do |value|
      arr.push(proc.call(value))
    end
    arr
  end

  # Modify your #my_map method to take either a proc or a block.
  # It won't be necessary to apply both a proc and a block in the same #my_map call
  # since you could get the same effect by chaining together one #my_map call with the block
  # and one with the proc. This approach is also clearer, since the user doesn't have to remember
  # whether the proc or block will be run first.
  # So if both a proc and a block are given, only execute the proc.
  def my_map(proc = nil)
    arr = []
    my_each do |value|
      to_push = proc.nil? ? yield(value) : proc.call(value)
      arr.push(to_push)
    end
    arr
  end
end

# Test your #my_inject by creating a method called #multiply_els which multiplies all
# the elements of the array together by using #my_inject, e.g. multiply_els([2,4,5]) #=> 40
def multiply_els(arr)
  arr.my_inject(1) { |total, x| total * x }
end

p [1,1,1].my_all?(Integer)