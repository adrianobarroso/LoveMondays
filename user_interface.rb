class UserInterface
  def initialize(game)
    @game = game
  end

  def show_game_status
    message = " #{@game.board[0]} | #{@game.board[1]} | #{@game.board[2]} \n===+===+===\n"
    message += " #{@game.board[3]} | #{@game.board[4]} | #{@game.board[5]} \n===+===+===\n"
    message += " #{@game.board[6]} | #{@game.board[7]} | #{@game.board[8]} \n"
    puts message
    puts "Entry: [0-8]"
  end

  def finish
    puts "Game over"
  end

  def self.level
    puts "Please entry the level you want to play: [0: easy - 1: intermediate - 2: hard]"
    gets.chomp
  end
end
