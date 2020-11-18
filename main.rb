# frozen_string_literal: true
require 'pry'

# My module Enumerable
module Enumerable
  # Create #my_each, a method that is identical to #each but (obviously) does not use #each.
  # You'll need to remember the yield statement. 
  # Make sure it returns the same thing as #each as well.
  def my_each
    for value in self do
      yield(value)
    end
  end

  # Create #my_each_with_index in the same way.
  def my_each_with_index
    index = 0
    for value in self do
      yield(value, index)
      index += 1
    end
  end

  # Create #my_select in the same way, though you may use #my_each in your definition (but not #each).
  def my_select
    arr = []
    my_each do |value|
      arr.push(value) if yield(value)
    end
  end

  # Create #my_all? (continue as above)
  def my_all?
    result = true
    my_each do |value|
      return false unless yield(value)
    end
    result
  end

  # Create #my_any?
  def my_any?
    result = false
    my_each do |value|
      return true if yield(value)
    end
    result
  end

  # Create #my_none?
  def my_none?
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
  def my_map
    arr = []
    my_each do |value|
      arr.push(yield(value))
    end
    arr
  end

  # Create #my_inject
  # Test your #my_inject by creating a method called #multiply_els which multiplies all the elements of the array together by using #my_inject, e.g. multiply_els([2,4,5]) #=> 40
  # Modify your #my_map method to take a proc instead.
  # Modify your #my_map method to take either a proc or a block. It won't be necessary to apply both a proc and a block in the same #my_map call since you could get the same effect by chaining together one #my_map call with the block and one with the proc. This approach is also clearer, since the user doesn't have to remember whether the proc or block will be run first. So if both a proc and a block are given, only execute the proc.
end

p (1..9).my_map { |x| x * 2 }

# p [2, 4].my_none? { |x| x % 2 == 0 }