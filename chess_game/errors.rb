require 'colorize'

class OutOfBoundsError < StandardError
  def message
    "\n << Position out of bounds >>".light_red
  end
end

class NoPieceError < StandardError
  def message
    "\n << There is no piece at that pos >>".light_red
  end
end
