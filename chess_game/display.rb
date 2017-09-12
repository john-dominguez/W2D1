require 'colorize'
require 'byebug'
require_relative 'board.rb'
require_relative 'cursor.rb'
require_relative 'errors.rb'

class Display
  attr_reader :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    system 'clear'
    nice_header
    grid
  end

  def nice_header
    print '    ' + ('a'..'h').to_a.join('  ') + "\n"
  end

  def grid
    @board.grid.each_with_index do |row, idx|
      print "#{idx + 1}  "
      odd = idx.odd? ? false : true
      row.each_with_index do |piece, idx2|
        if @cursor.cursor_pos == [idx, idx2]
          print " #{piece.inspect} ".red.on_light_yellow.blink
        else
          if odd
            print " #{piece.inspect} ".black.on_light_white
          else
            print " #{piece.inspect} ".light_white.on_black
          end
        end
        odd = !odd
      end
      puts ''
    end
  end
end

def dummy_play
  a = Display.new(Board.new)
  100.times do |_count|
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

dummy_play
