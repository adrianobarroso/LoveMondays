class Game
  attr_reader :com, :hum
  attr_accessor :board, :level

  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @com = "X" # the computer's marker
    @hum = "O" # the user's marker
    @level = nil #Validation.level_validation(level)
  end

  def eval_board
    spot = nil
    until spot
      if @board[4] == "4" && @level == "3"
        # spot = 4
        @board[4] = @com
      else
        spot = get_best_move(@board, @com, @level.to_i * 2)
        @board[spot] != "X" && @board[spot] != "O" ? @board[spot] = @com : spot = nil
      end
    end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spaces = []
    best_move = nil

    board.each do |s|
      available_spaces << s if s != "X" && s != "O"
    end
    available_spaces.first(depth).each do |as|
      board[as.to_i] = @com
      if game_is_over(board)
        best_move = as.to_i
        board[as.to_i] = as
        return best_move
      else
        board[as.to_i] = @hum
        if game_is_over(board)
          best_move = as.to_i
          board[as.to_i] = as
          return best_move
        end
        board[as.to_i] = as
      end
    end

    return best_move if best_move
    n = rand(0..available_spaces.count)
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

end
