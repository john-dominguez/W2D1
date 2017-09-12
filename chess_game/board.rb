require_relative 'piece.rb'
require_relative 'errors.rb'

class Board
  attr_reader :grid

  def self.populated
    a = Board.new
    a.populate
    a
  end

  def self.deep_dup(board)
    copy = Board.new(board.grid)
    copy.grid.each_with_index do |row, idx|
      row.each_with_index do |piece, idx2|
        unless piece.is_a?(NullPiece)
          copy_piece = Piece.deep_dup(piece, copy)
          copy[[idx, idx2]] = copy_piece
        end
      end
    end
    copy
  end



  def initialize(grid = Array.new(8) { Array.new(8) { NullPiece.instance } })
    # grid ||= Array.new(8) { Array.new(8) { NullPiece.instance } }
    @grid = grid
  end

  # instance method ??
  # def deep_dup
  #   copy = Board.new(self.grid)
  #   copy.grid.each_with_index do |row, idx|
  #     row.each_with_index do |piece, idx2|
  #       unless piece.is_a?(NullPiece)
  #         copy_piece = piece.deep_dup(copy)
  #         copy[[idx, idx2]] = copy_piece
  #       end
  #     end
  #   end
  #   copy
  # end

  def in_check?(color)
    op_color = (color == :white) ? :black : :white
    king_pos = select_piece(King, color)[0].pos
    select_pieces(op_color).any?{|piece| piece.moves.include?(king_pos)}
  end

  def checkmate(color)
    # :NB
    in_check?(color) && valid_moves(color).empty?
  end

  def move_piece(start_pos, end_pos)
    debugger
    piece1 = self[start_pos]
    raise NoPieceError if piece1.is_a?(NullPiece)
    loc = self[end_pos]
    raise OutOfBoundsError unless in_range?(end_pos)
    self[end_pos] = piece1
    piece1.pos = end_pos
    self[start_pos] = loc
  end

  def in_range?(pos)
    # self[pos] != nil
    x, y = pos
    x.between?(0, 7) && y.between?(0, 7)
  end

  def inspect
    p @grid
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

  # private ::NB::

  def select_pieces(color)
    pieces = []
    @grid.each do |row|
      # debugger
      row.each do |piece|
        if piece.color == color
          pieces << piece
        end
      end
    end
    pieces
  end

  def select_piece(type, color)
    select_pieces(color).select{|piece| piece.is_a?(type)}
  end

  def populate
    @grid.each_with_index do |row, idx|
      row.each_with_index do |place, idx2|
        pos = idx, idx2
        case idx
        when 0
          case idx2
          when 0, 7
            self[pos] = Rook.new(:black, self, pos)
          when 1, 6
            self[pos] = Knight.new(:black, self, pos)
          when 2, 5
            self[pos] = Bishop.new(:black, self, pos)
          when 3
            self[pos] = King.new(:black, self, pos)
          when 4
            self[pos] = Queen.new(:black, self, pos)
          end
        when 1
          self[pos] = Pawn.new(:black, self, pos)
        when 2, 3, 4, 5
          self[pos] = NullPiece.instance
        when 6
          self[pos] = Pawn.new(:white, self, pos)
        when 7
          case idx2
          when 0, 7
            self[pos] = Rook.new(:white, self, pos)
          when 1, 6
            self[pos] = Knight.new(:white, self, pos)
          when 2, 5
            self[pos] = Bishop.new(:white, self, pos)
          when 3
            self[pos] = King.new(:white, self, pos)
          when 4
            self[pos] = Queen.new(:white, self, pos)
          end
        end
      end
    end
  end
end


def board_test
  b = Board.new
  # debugger
  k = King.new(:white, b, [1,2])
  b.place_piece(k, [1,2])
  r = Rook.new(:black, b, [0,4])
  b.place_piece(r, [0,4])
  debugger
  x = k.valid_moves
  debugger
end

board_test
