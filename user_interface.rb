class UserInterface
  def initialize(game)
    @game = game
  end

  def game_type
    message = "Please entry which mode do you want to play: \n1 = player vs computer "
    message += "\n2 = player vs player \n3 = computer vs computer"
    puts message
    gets.chomp
  end

  def show_game_status
    message = " #{@game.board[0]} | #{@game.board[1]} | #{@game.board[2]} \n===+===+===\n"
    message += " #{@game.board[3]} | #{@game.board[4]} | #{@game.board[5]} \n===+===+===\n"
    message += " #{@game.board[6]} | #{@game.board[7]} | #{@game.board[8]} \n"
    puts message
  end

  def finish
    show_game_status
    puts ""
    puts ""
    puts @game.show_winner
    puts ""
    puts ""
  end

  def ask_entry(type)
    if type == "hum"
      puts "\nPlayer 1 move"
    elsif type == "com"
      puts "\nPlayer 2 move"
    end
    puts "Entry: [0-8]"
    gets.chomp
  end

  def level
    puts "Please entry the level you want to play: \n1 = easy \n2 = intermediate \n3 = hard"
    gets.chomp
  end
end
