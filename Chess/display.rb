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
    won = false

    until won
      # system('clear')
      render
      input = cursor.get_input
      #to do :highlight intial selected and cursor pos
      #if not intial selected, and cursor leaves pos, unselect
      p board[cursor.cursor_pos].class

      if input == cursor.cursor_pos
        board[(cursor.cursor_pos)].toggle_selected
      end
      potential_move
    end
  end

  def potential_move
    selected_pos = []
    board.grid.each_with_index do |row, rowidx|
      row.each_index do |colidx|
        pos = [rowidx, colidx]
        current_piece = board[pos]
        selected_pos << pos if current_piece.selected
      end
    end
    if selected_pos.length == 2
      puts "i'm in potential"
      end_pos = cursor.cursor_pos
      selected_pos -= cursor.cursor_pos
      start_pos = selected_pos.first

      p start_pos
      p end_pos
      puts 'leaving potential'
      board.move_piece(start_pos, end_pos)
      board[end_pos].toggle_selected
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
