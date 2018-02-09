require 'pry'

require_relative 'tictactoe.rb'
require_relative 'validation.rb'
require_relative 'user_interface.rb'

def start_game
  enter_game

  until @game.game_is_over(@game.board) || @game.tie(@game.board)
    get_human_spot("hum") if @game.game_mode != "3"
    if !@game.game_is_over(@game.board) && !@game.tie(@game.board) && @game.game_mode != "2"
      mode = @game.select_player
      @game.eval_board(mode)
    else
      get_human_spot("com")
    end
  end
  @view.finish
end

def get_human_spot(type)
  loop do
    @view.show_game_status
    validation = Validation.new(@game.board, @view.ask_entry)
    validation.validates
    if validation.pass
      @game.board[validation.number.to_i] = type == "hum" ? @game.hum : @game.com
      break
    end
  end
end

def enter_game
  loop do
    validation_enter = Validation.new(@game.board, @view.game_type)
    validation_enter.number_validation

    if validation_enter.number == "1" && validation_enter.pass
      validation_level = Validation.new(@game.board, @view.level)
      validation_level.number_validation

      if validation_level.pass
        @game.level = validation_level.number
        break
      end
    elsif validation_enter.pass
      @game.game_mode = validation_enter.number
      break
    end
  end
end

@game = Game.new
@view = UserInterface.new(@game)

start_game
