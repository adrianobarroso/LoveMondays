class Game
  attr_reader :com, :hum
  attr_accessor :board, :level, :game_mode

  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @com = "X" # the computer's marker
    @hum = "O" # the user's marker
    @game_mode = nil
    @level = nil
  end

  def eval_board(mode)
    if @board[4] == "4" && @level == "3"
      @board[4] = mode
    else
      spot = get_best_move(@board, mode, @level.to_i * 2)
      @board[spot] = mode
    end
  end

  def get_best_move(board, next_player, depth = 1)
    available_spaces = board.select { |s| s != "X" && s != "O" }
    available_spaces.first(depth).each do |as|
      # case computer win on next move
      board[as.to_i] = @com
      return as.to_i if game_is_over(board)
      # case user win on next move
      board[as.to_i] = @hum
      return as.to_i if game_is_over(board)

      board[as.to_i] = as
    end
    n = rand(0..available_spaces.count - 1)
    return available_spaces[n].to_i
  end

  def game_is_over(b)
    [b[0], b[1], b[2]].uniq.length == 1 ||
    [b[3], b[4], b[5]].uniq.length == 1 ||
    [b[6], b[7], b[8]].uniq.length == 1 ||
    [b[0], b[3], b[6]].uniq.length == 1 ||
    [b[1], b[4], b[7]].uniq.length == 1 ||
    [b[2], b[5], b[8]].uniq.length == 1 ||
    [b[0], b[4], b[8]].uniq.length == 1 ||
    [b[2], b[4], b[6]].uniq.length == 1
  end

  def tie(b)
    b.all? { |s| s == "X" || s == "O" }
  end

  def select_player
    return "X" if @game_mode != "3"
    @board.select { |s| s != "X" && s != "O" }.size.odd? ? "O" : "X"
  end
end
