require_relative 'piece'

class NoStartingPieceError < StandardError
end
class NotOnBoardError < StandardError
end
class InvalidMoveError < StandardError
end


class Board

  attr_accessor :grid
  def initialize
    @grid = Array.new(8) { |row| Array.new (8) { |col| NullPiece.new([row,col], self)} } ## second argument for piece

    pos_n = [1, 2]
    pos_k = [0, 0]

    self[pos_n] = Knight.new(pos_n, self)
    self[pos_k] = King.new(pos_k, self)
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
    p start_pos
    p end_pos
    raise NoStartingPieceError unless self[start_pos].is_a?(Piece)
    raise NotOnBoardError unless end_pos.all? { |coord| coord.between?(0, 7) }
    raise InvalidMoveError unless self[start_pos].valid_moves.include?(end_pos)
    self[end_pos] = self[start_pos]
    self[end_pos].pos = end_pos
    self[start_pos].pos = start_pos
    self[start_pos] = NullPiece.new(start_pos, self)
  end

end
