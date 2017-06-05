class NoStartingPieceError < StandardError
end
class NotOnBoardError < StandardError
end


class Board


  def initialize
    @grid = Array.new(8) {Array.new (8) {Piece.new()} }
  end

  # def [](pos)
  #   row, col = pos[0], pos[1]
  #   @grid[row][col]
  # end
  #
  # def []=(pos,value)
  #   row, col = pos[0], pos[1]
  #   @grid[row][col] = value
  # end

  def move_piece(start_pos, end_pos)
    raise NoStartingPieceError unless @grid[start_pos[0]][start_pos[1]].is_a?(Piece)
    raise NotOnBoardError unless end_pos.all? { |coord| coord.between?(0..7) }
    @grid[start_pos[0]][start_pos[1]] == @grid[end_pos[0]][end_pos[1]]

  end

end
