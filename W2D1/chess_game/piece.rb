class Piece
  def initialize
  end
  def inspect
    "p"
  end
end

class NullPiece < Piece
  def initialize

  end

  def inspect
    "n"
  end
end
