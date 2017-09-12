require 'colorize'

class OutOfBoundsError < StandardError
  def message
    "\n << Position out of bounds >>".light_red
  end
end
