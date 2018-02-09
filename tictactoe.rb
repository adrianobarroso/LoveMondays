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

  def find_winner(b)
    return b[0] if [b[0], b[1], b[2]].uniq.length == 1
    return b[3] if [b[3], b[4], b[5]].uniq.length == 1
    return b[6] if [b[6], b[7], b[8]].uniq.length == 1
    return b[0] if [b[0], b[3], b[6]].uniq.length == 1
    return b[1] if [b[1], b[4], b[7]].uniq.length == 1
    return b[2] if [b[2], b[5], b[8]].uniq.length == 1
    return b[0] if [b[0], b[4], b[8]].uniq.length == 1
    return b[2] if [b[2], b[4], b[6]].uniq.length == 1
  end

  def show_winner
    winner = find_winner(@board)
    return "Player won!!!" if @game_mode == "1" && winner == "O"
    return "Player 1 won!!!" if @game_mode == "2" && winner == "O"
    return "Player 2 won!!!" if @game_mode == "2" && winner == "X"
    return "Computer 1 won!!!" if @game_mode == "3" && winner == "O"
    return "Computer 2 won!!!" if @game_mode == "3" && winner == "X"
    return "Game Tied!!! Nobody wins..." if tie(@board)
    
    "Game Over!!!"
  end

  def tie(b)
    b.all? { |s| s == "X" || s == "O" }
  end

  def select_player
    return "X" if @game_mode != "3"
    @board.select { |s| s != "X" && s != "O" }.size.odd? ? "O" : "X"
  end
end
