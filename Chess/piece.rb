require 'colorize'

class Piece

  attr_accessor :name, :pos, :symbol, :selected, :color, :board

  def initialize(starting_pos, board)
    @pos = starting_pos
    @name = 'piece'
    @symbol = ":p".colorize(color)
    @selected = false
    @color = :black
    @board = board
  end

  def toggle_selected
    if @selected
      @selected = false
    else
      @selected = true
    end
  end

  def valid_moves
    moves
  end

end


class NullPiece < Piece
  # include Singleton

  attr_reader :color, :symbol

  def initialize(start_pos, board)
    super
    @color = :blue
    @symbol = ' '
  end



end


module SteppingPiece

  def moves
    moves = []
    move_diffs.each do |diff|
      new_x = pos[0] + diff[0]
      new_y = pos[1] + diff[1]

      new_pos = [new_x, new_y]
      other_piece = board[new_pos]

      next unless (new_x).between?(0,7) && (new_y).between?(0,7)
      next if other_piece.color == self.color
      moves << new_pos
      next if other_piece.color != self.color && !other_piece.is_a?(NullPiece)
    end

    moves
  end

  private


end

#stepping
class King < Piece
  include SteppingPiece

  def initialize(start_pos, board)
    super
    @symbol = 'K'.colorize(color)
  end


  protected

  def move_diffs
      [[0, 1],
      [0, -1],
      [1, 0],
      [-1, 0],
      [1, 1],
      [1, -1],
      [-1, 1],
      [-1, -1] ]
  end

end

class Knight < Piece
  include SteppingPiece

    def initialize(start_pos, board)
      super
      @symbol = 'N'.colorize(color)
    end


  protected

  def move_diffs
    [[2, 1],
    [2, -1],
    [-2, 1],
    [-2, -1],
    [1, 2],
    [1, -2],
    [-1, 2],
    [-1, -2] ]
  end


end


module SlidingPiece

  HDIFFS = [
    [0, 1],
    [0, -1],
    [1, 0],
    [-1, 0] ]

  DDIFFS = [
    [1, 1],
    [1, -1],
    [-1, 1],
    [-1, -1] ]

  def moves
    moves = []
    move_dirs.each do |diff|
      moves += grow_unblocked_moves_in_dir(diff[0], diff[1])
    end
    moves
  end

  private

  # def move_dirs
  # end

  def horizontal_dirs
    HDIFFS
  end

  def diagonal_dirs
    DDIFFS
  end

  def grow_unblocked_moves_in_dir (dx, dy)
      moves = []
      new_x = pos[0] + dx
      new_y = pos[1] + dy


      while (new_x).between?(0,7) && (new_y).between?(0,7)
        new_pos = [new_x, new_y]
        other_piece = board[new_pos]
        break if other_piece.color == self.color
        moves << new_pos
        break if other_piece.color != self.color && !other_piece.is_a?(NullPiece)
        new_x += dx
        new_y += dy
      end
        moves
  end

end

class Queen < Piece
  include SlidingPiece

  def initialize(start_pos, board)
    super
    @symbol = 'Q'.colorize(color)
  end

  protected

  def move_dirs
    horizontal_dirs+diagonal_dirs
  end


end


class Bishop < Piece
  include SlidingPiece

  def initialize(start_pos, board)
    super
    @symbol = 'B'.colorize(color)
  end

  protected

  def move_dirs
    diagonal_dirs
  end


end


class Rook < Piece
  include SlidingPiece

  def initialize(start_pos, board)
    super
    @symbol = 'R'.colorize(color)
  end

  protected

  def move_dirs
    horizontal_dirs
  end


end


class Pawns < Piece
  def symbol
  end

  def moves
  end

  protected

  def move_dirs
  end

  def at_start_row?
  end

  def forward_dir
  end

  def forward_steps
  end

  def side_attacks
  end

end
