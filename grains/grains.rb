class Grains
  def square(number)
    if number == 1
      square_totals[number] ||= 1
    else
      square_totals[number] ||= 2 * square(number - 1)
    end
  end

  def total
    (1..64).reduce(0) do |sum, square_number|
      sum + square(square_number)
    end
  end

  private

  def square_totals
    @square_totals ||= Hash.new(nil)
  end
end
