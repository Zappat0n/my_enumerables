# frozen_string_literal: true

# My module Enumerable
module Enumerable
  def my_each
    for value in self do
      yield(value)
    end
  end
end

(1..9).my_each { |x| p x }
