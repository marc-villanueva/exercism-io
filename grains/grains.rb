class Grains
  attr_reader :total_number_of_squares

  def initialize(total_number_of_squares=64)
    @total_number_of_squares = total_number_of_squares
  end

  def square(number)
    2 ** (number - 1)
  end

  def total
    (1..total_number_of_squares).map(&method(:square)).reduce(:+)
  end
end
