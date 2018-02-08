class Validation
  attr_reader :pass, :spot

  def initialize(board, spot)
    @board = board
    @spot = spot
    @pass = true
    validates
  end

  def validates
    handle_error(1) unless is_integer?
    handle_error(2) unless check_board
    handle_error(3) unless range
  end

  def check_board
    @board[@spot.to_i] != "X" && @board[@spot.to_i] != "O"
  end

  def is_integer?
    true if Integer(@spot) rescue false
  end

  def range
    (0..8).include? @spot.to_i
  end

  def handle_error(n)
    @pass = false
    puts "\nError"
    message = "\t########## \n\tInput number is not an integer \n\t##########" if n == 1
    message = "\t########## \n\tSpot location already selected \n\t##########" if n == 2
    message = "\t########## \n\tInput number not in the range [0..8]\n\t##########" if n == 3
    puts message
    puts "\nPlease send a valid input\n\n"
  end
end
