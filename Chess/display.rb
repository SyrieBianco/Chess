require 'colorize'
require_relative 'board'
require_relative 'cursor'
class Display
  attr_reader :cursor, :board, :count
  def initialize
    @cursor = Cursor.new([0,0])
    @board = Board.new
    @count = 0
  end

  def move_cursor
    won = 0
    until won == 10
      system('clear')
      render
      input = cursor.get_input
      #highlight intial selected and cursor pos
      #if not intial selected, and cursor leaves pos, unselect
      if input == cursor.cursor_pos
        board[(cursor.cursor_pos)].toggle_selected
      end
      won += 1
    end
  end

  def render
    @count = 0
    board.grid.each_with_index do |row, rowidx|
      row.each_index do |colidx|
        pos = [rowidx, colidx]
        current_piece = board[pos]
        display_piece(rowidx, colidx, current_piece)
      end
    end
  end

  def display_piece(rowidx, colidx, current_piece)
    background = set_background(rowidx, colidx)
    #assign this background as the colorize background

    if colidx == 7 && rowidx != 7
      print " #{current_piece.symbol} ".colorize(:background => background)
      puts

      @count += 1
    else
      print " #{current_piece.symbol} ".colorize(:background => background)
    end
  end

  def set_background(rowidx, colidx)
    @count += 1
    if board.grid[rowidx][colidx].selected #cursor there and selected
      :light_magenta
    elsif [rowidx, colidx] == @cursor.cursor_pos #cursor there
      :light_cyan
    elsif count.even?
      :light_black
    else count.odd?
      :light_white
    end
  end

end

Display.new.move_cursor
