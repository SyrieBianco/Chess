require_relative 'piece'
class NoStartingPieceError < StandardError
end
class NotOnBoardError < StandardError
end


class Board

  attr_accessor :grid
  def initialize
    @grid = Array.new(8) { |row| Array.new (8) { |col| Piece.new([row,col])} }
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos,value)
    row, col = pos
    @grid[row][col] = value
  end

  def move_piece(start_pos, end_pos)
    raise NoStartingPieceError unless self[start_pos].is_a?(Piece)
    raise NotOnBoardError unless end_pos.all? { |coord| coord.between?(0, 7) }
    self[end_pos] = self[start_pos]

  end

end
