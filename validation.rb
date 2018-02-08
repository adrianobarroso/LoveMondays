class Validation
  attr_reader :pass, :spot

  def initialize(board, spot)
    @board = board
    @spot = spot
    @pass = true
    validates
  end

  def validates
    handle_error(1) unless is_integer?(@spot)
    handle_error(2) unless check_board?
    handle_error(3) unless range?
  end

  def check_board?
    @board[@spot.to_i] != "X" && @board[@spot.to_i] != "O"
  end

  def is_integer?(n)
    true if Integer(n) rescue false
  end

  def range?
    (0..8).include? @spot.to_i
  end

  def range_level?(level)
    (0..2).include? level.to_i
  end

  def self.level_validation(level)
    handle_error(1) unless is_integer?(level)
    handle_error(4) unless range_level?(level)
  end

  def handle_error(n)
    @pass = false
    puts "\nError"
    message = "\t########## \n\tInput number is not an integer \n\t##########" if n == 1
    message = "\t########## \n\tSpot location already selected \n\t##########" if n == 2
    message = "\t########## \n\tInput number not in the range [0..8]\n\t##########" if n == 3
    message = "\t########## \n\tLevel input not in the range [0..2]\n\t##########" if n == 4
    puts message
    puts "\nPlease send a valid input\n\n"
  end
end
