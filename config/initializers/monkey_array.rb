class Array
  def sum
    compact.inject(0.0) { |result, el| result + el }
  end

  def mean
    sum / compact.size
  end
end
