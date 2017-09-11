require 'colorize'
require 'byebug'
require_relative 'board.rb'
require_relative 'cursor.rb'
require_relative 'errors.rb'
class Display
  attr_reader :cursor
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    system "clear"
    p "  #{('a'..'h').to_a.join('  ')}"
    @board.grid.each_with_index do |row, idx|
      print "#{idx+1}  "
      row.each_with_index do |piece, idx2|
        if [idx, idx2] == @cursor.cursor_pos
          print "#{piece.inspect}  ".red
        else

        print "#{piece.inspect}  "
        end
      end
      puts ""
    end
  end

end

def dummy_play

  a = Display.new(Board.new)
  100.times do |count|

  a.render
  #  debugger
  begin
    a.cursor.get_input
  rescue OutOfBoundsError => e
    puts e.message
    retry
  end
  end
end
