# frozen_string_literal: true
require 'pry'

# My module Enumerable
module Enumerable
  # Create #my_each, a method that is identical to #each but (obviously) does not use #each.
  #You'll need to remember the yield statement. 
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
    self.my_each do |value|
      arr.push(value) if yield(value)
    end
  end
  
  # Create #my_any?
  # Create #my_none?
  # Create #my_count
  # Create #my_map
  # Create #my_inject
  # Test your #my_inject by creating a method called #multiply_els which multiplies all the elements of the array together by using #my_inject, e.g. multiply_els([2,4,5]) #=> 40
  # Modify your #my_map method to take a proc instead.
  # Modify your #my_map method to take either a proc or a block. It won't be necessary to apply both a proc and a block in the same #my_map call since you could get the same effect by chaining together one #my_map call with the block and one with the proc. This approach is also clearer, since the user doesn't have to remember whether the proc or block will be run first. So if both a proc and a block are given, only execute the proc.
end

#(1..9).my_each { |x| p x }

#(1..9).my_each_with_index { |x, i| p "Index: #{i} and Value: #{x}" }

#(1..9).my_select { |x| x % 2 == 0 }

p [2, 4].my_all? { |x| x % 2 == 0 }