class Piece
  attr_accessor :name, :pos, :symbol, :selected, :color

  def initialize(starting_pos)
    @pos = starting_pos
    @name = 'piece'
    @symbol = ":p".colorize(color)
    @selected = false
    @color = :black
  end

  def toggle_selected
    if @selected
      @selected = false
    else
      @selected = true
    end
  end


end
