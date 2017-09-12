require 'singleton'
require 'byebug'
require_relative 'board.rb'

DIRECTIONS = {
  horizontal: [[0, 1], [0, -1]],
  vertical: [[1, 0], [-1, 0]],
  diagonal: [[1, 1], [-1, -1], [1, -1], [-1, 1]]
}.freeze

module SlidingPiece
  def moves
    moves = []
    move_dirs.each do |direction|
      debugger
      moves.concat(add_move_dirs(direction))
    end
    moves
  end

  def add_move_dirs(direction)
    moves = []
    DIRECTIONS[direction].each do |delta|
      moves.concat(grow_moves_in_dir(delta))
    end
    debugger
    moves
  end

  def grow_moves_in_dir(delta)
    arr1 = pos
    pos = sum_delta(arr1, delta)
    moves = []
    while valid_place?(pos)
      # debugger
      moves << pos
      pos = sum_delta(pos, delta)
    end
    moves
  end

  private

  def sum_delta(arr1, delta)
    [arr1, delta].transpose.map { |arr| arr.reduce(:+) }
  end

  def valid_place?(pos)
    @board.in_range?(pos) && (@board[pos].color != color)
  end
end

module SteppingPiece
  def move_dirs; end
end

class Piece
  attr_reader :color, :pos

  def initialize(color, board, starting_pos)
    @color = color
    @board = board
    @pos = starting_pos
  end

  def moves; end
end

class NullPiece < Piece
  include Singleton
  def initialize; end

  def inspect
    'n'
  end
end

class Rook < Piece
  include SlidingPiece
  def move_dirs
    %i[horizontal vertical]
  end
end

class Queen < Piece
  include SlidingPiece
  def move_dirs
    %i[horizontal vertical diagonal]
  end
end
[1,2,3,4,5]
class King < Piece
  include SteppingPiece
end

class Pawn < Piece
end
