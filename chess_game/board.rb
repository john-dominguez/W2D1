require_relative 'piece.rb'
require_relative 'errors.rb'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) { NullPiece.instance } }
  end

  def move_piece(start_pos, end_pos)
    piece1 = self[start_pos]
    raise NoPieceError if piece1.is_a?(NullPiece)
    loc = self[end_pos]
    raise OutOfBoundsError unless in_range?(end_pos)
    self[end_pos] = piece1
    self[start_pos] = loc
  end

  def in_range?(pos)
    # self[pos] != nil
    x, y = pos
    x.between?(0, 7) && y.between?(0, 7)
  end

  def inspect
    @grid
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def place_piece(piece, pos)
    self[pos] = piece
  end
end
