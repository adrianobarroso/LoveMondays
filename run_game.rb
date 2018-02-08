require 'pry'

require_relative 'tictactoe.rb'
require_relative 'validation.rb'
require_relative 'user_interface.rb'

def start_game
  loop do
    validation = Validation.new(@game.board, @view.level)
    validation.level_validation
    if validation.pass
      @game.level = validation.number
      break
    end
  end
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
    validation = Validation.new(@game.board, @view.ask_entry)
    validation.validates
    if validation.pass
      @game.board[validation.number.to_i] = @game.hum
      break
    end
  end
end

@game = Game.new
@view = UserInterface.new(@game)

start_game
