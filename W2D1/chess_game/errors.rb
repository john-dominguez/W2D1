class OutOfBoundsError < StandardError
  def message
    "Position out of bounds"
  end
end
