require 'pry'

require_relative 'tictactoe.rb'
require_relative 'validation.rb'
require_relative 'user_interface.rb'

def start_game
  until @game.game_is_over(@game.board) || @game.tie(@game.board)
    get_human_spot
    if !@game.game_is_over(@game.board) && !@game.tie(@game.board)
      @game.eval_board
    end
  end
  @view.finish
end

def get_human_spot
  loop do
    @view.show_game_status
    @view.ask_entry
    validates = Validation.new(@game.board, gets.chomp)
    if validates.pass
      @game.board[validates.spot.to_i] = @game.hum
      break
    end
  end
end

level = UserInterface.level
@game = Game.new(level)
@view = UserInterface.new(@game)

start_game
