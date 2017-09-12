require 'singleton'
require 'byebug'
# require_relative 'board.rb'

DIRECTIONS = {
  horizontal: [[0, 1], [0, -1]],
  vertical: [[1, 0], [-1, 0]],
  diagonal: [[1, 1], [-1, -1], [1, -1], [-1, 1]],
  knight: [[2, 1], [2, -1], [-2, 1], [-2, -1], [1, 2], [-1, 2], [1, -2], [-1, -2]]
}.freeze

module SlidingPiece
  def grow_moves_in_dir(delta)
    arr1 = pos
    pos = sum_delta(arr1, delta)
    moves = []
    while valid_place?(pos)
      moves << pos
      pos = sum_delta(pos, delta)
    end
    moves
  end
end

module SteppingPiece
  def grow_moves_in_dir(delta)
    arr1 = pos
    pos = sum_delta(arr1, delta)
    return [pos] if valid_place?(pos)
    []
  end
end

class Piece
  attr_reader :color, :symbol
  attr_accessor :pos

  def self.deep_dup(piece, board)
    piece.class.new(piece.color, board, piece.pos)
  end

  # instance method ??
  # def deep_dup(board)
  #   self.class.new(self.color, board, self.pos)
  # end

  def initialize(color, board, starting_pos)
    @color = color
    @board = board
    @pos = starting_pos
  end

  def inspect
    @symbol
  end

  def moves_into_check(to_pos); end

  def moves
    moves = []
    move_dirs.each do |direction|
      moves.concat(add_move_dirs(direction))
    end
    moves
  end

  def valid_moves
    debugger
    moves.reject do |move|
      board_copy = Board.deep_dup(@board)
      debugger
      board_copy.move_piece(pos, move)
      board_copy.in_check?(color)
    end
  end

  private

  def add_move_dirs(direction)
    moves = []
    DIRECTIONS[direction].each do |delta|
      moves.concat(grow_moves_in_dir(delta))
    end
    moves
  end

  def sum_delta(arr1, delta)
    [arr1, delta].transpose.map { |arr| arr.reduce(:+) }
  end

  def valid_place?(pos)
    @board.in_range?(pos) && (@board[pos].color != color)
  end
end

class NullPiece < Piece
  include Singleton

  def initialize
    # @symbol = " "
  end

  def symbol
    " "
  end
end

class Rook < Piece
  include SlidingPiece

  def initialize(*args)
    # debugger
    super
    @symbol = @color == :white ? "\u2656" : "\u265C"
    # debugger
  end

  def move_dirs
    %i[horizontal vertical]
  end
end

class Bishop < Piece
  include SlidingPiece

  def initialize(*args)
    super
    @symbol = @color == :white ? "\u2657" : "\u265D"
  end

  def move_dirs
    [:diagonal]
  end
end

class Knight < Piece
  include SteppingPiece

  def initialize(*args)
    super
    @symbol = @color == :white ? "\u2658" : "\u265E"
  end

  def move_dirs
    [:knight]
  end
end

class Queen < Piece
  include SlidingPiece

  def initialize(*args)
    super
    @symbol = @color == :white ? "\u2655" : "\u265B"
  end

  def move_dirs
    %i[horizontal vertical diagonal]
  end
end

class King < Piece
  include SteppingPiece

  def initialize(*args)
    super
    @symbol = @color == :white ? "\u2654" : "\u265A"
  end

  def move_dirs
    %i[horizontal vertical diagonal]
  end
end

class Pawn < Piece
  def initialize(*args)
    super
    @symbol = @color == :white ? "\u2659" : "\u265F"
  end

  def at_start_row?; end

  def forward_dir; end

  def forward_steps; end

  def side_attacks; end
end
