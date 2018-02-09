class Validation
  attr_reader :pass, :number

  def initialize(board, number)
    @board = board
    @number = number
    @pass = true
  end

  def validates
    handle_error(1) unless is_integer?
    handle_error(2) unless check_board?
    handle_error(3) unless range?
  end

  def check_board?
    @board[@number.to_i] != "X" && @board[@number.to_i] != "O"
  end

  def is_integer?
    true if Integer(@number) rescue false
  end

  def range?
    (0..8).include? @number.to_i
  end

  def range_level?
    (1..3).include? @number.to_i
  end

  def number_validation
    handle_error(1) unless is_integer?
    handle_error(4) unless range_level?
  end

  def handle_error(n)
    @pass = false
    puts "\nError"
    message = "\t########## \n\tInput number is not an integer \n\t##########" if n == 1
    message = "\t########## \n\tSpot location already selected \n\t##########" if n == 2
    message = "\t########## \n\tInput number not in the range [0..8]\n\t##########" if n == 3
    message = "\t########## \n\tInput not in the range [1..3]\n\t##########" if n == 4
    puts message
    puts "\nPlease send a valid input\n\n"
  end
end
