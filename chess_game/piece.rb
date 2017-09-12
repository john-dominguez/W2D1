require 'singleton'
class Piece
  def initialize
  end
  def inspect
    "p"
  end
end

class NullPiece < Piece
  include Singleton
  def initialize

  end

  def inspect
    "n"
  end
end
