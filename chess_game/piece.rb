require 'singleton'
require 'byebug'
require_relative 'board.rb'

DIRECTIONS = {
  horizontal: [[0, 1], [0, -1]],
  vertical: [[1, 0], [-1, 0]],
  diagonal: [[1, 1], [-1, -1], [1, -1], [-1, 1]]
}

module SlidingPiece

  def moves

  end

  def horizontal_dirs()
    moves = []
    DIRECTIONS[:horizontal].each do |delta|
      moves << grow_moves_in_dir(delta)
    end
    moves
  end

  def grow_moves_in_dir(delta)
    arr1 = self.pos
    pos = sum_delta(arr1, delta)
    moves = []
    until !valid_place?(pos)
      # debugger
      moves << pos
      pos = sum_delta(pos, delta)
    end
    moves
  end

  private

  def sum_delta(arr1, delta)
    [arr1, delta].transpose.map {|arr| arr.reduce(:+)}
  end

  def valid_place?(pos)
    @board.in_range?(pos) && (@board[pos].color != self.color)
  end
  
end

module SteppingPiece
  def move_dirs

  end
end

class Piece

  attr_reader :color, :pos

  def initialize(color, board, starting_pos)
    @color = color
    @board = board
    @pos = starting_pos
  end

  def moves
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

class Rook < Piece
  include SlidingPiece
  def move_dirs
    [:horizontal]
  end
end

class King < Piece
  include SteppingPiece

end

class Pawn < Piece

end
