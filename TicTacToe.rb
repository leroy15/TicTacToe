class Player
  attr_reader :name
  attr_reader :sign
  
  def initialize(name,sign)
    @name = name
    @sign = sign
  end
end

class Board 
  def initialize
    @board_lines = [" ", " ", " ", " ", " ", " ", " ", " ", " "] #leeres Brett  
  end
  
  def show_board
    puts "-------------"
    puts "| #{@board_lines[0]} | #{@board_lines[1]} | #{@board_lines[2]} | "
    puts "-------------"
    puts "| #{@board_lines[3]} | #{@board_lines[4]} | #{@board_lines[5]} | "
    puts "-------------"
    puts "| #{@board_lines[6]} | #{@board_lines[7]} | #{@board_lines[8]} | "
    puts "-------------"
  end
  
  def win?(player)
    #horizontale Reihe
    (@board_lines[0] == player.sign && @board_lines[1] == player.sign && @board_lines[2] == player.sign) ||
    (@board_lines[3] == player.sign && @board_lines[4] == player.sign && @board_lines[5] == player.sign) ||
    (@board_lines[6] == player.sign && @board_lines[7] == player.sign && @board_lines[8] == player.sign) ||
    
    #vertikale Reihe
    (@board_lines[0] == player.sign && @board_lines[3] == player.sign && @board_lines[6] == player.sign) ||
    (@board_lines[1] == player.sign && @board_lines[4] == player.sign && @board_lines[7] == player.sign) ||
    (@board_lines[2] == player.sign && @board_lines[5] == player.sign && @board_lines[8] == player.sign) ||
    
    #diagonale Reihe
    (@board_lines[0] == player.sign && @board_lines[4] == player.sign && @board_lines[8] == player.sign) ||
    (@board_lines[2] == player.sign && @board_lines[4] == player.sign && @board_lines[6] == player.sign)
  end
  
  def choose_field
    puts "Chose your field: 0-8"
    field = gets.chomp.to_i

    while field < 0 || field > 8 || @board_lines[field] != " " 
      puts "Your fieldnumber is either not in the range between 0 and 8 or is already taken"
      puts "Please select your field again: "
      field = gets.chomp.to_i
    end

    return field
  end

  def update_field(field,sign)
    @board_lines[field] = sign #Ersetzt das leere Feld mit dem Spielersymbol
  end
  
  def board_full?
    @board_lines.all? {|field| field != " "} 
  end  
end

class Game
  def initialize
    #player1
    puts "Please enter the name of Player1"
    player1_name = gets.chomp
    puts "Please enter the sign of Player1"
    player1_sign = gets.chomp
    
    #player2
    puts "Please enter the name of Player2"
    player2_name = gets.chomp
    puts "Please enter the sign of Player2"
    player2_sign = gets.chomp
    
    while player1_sign == player2_sign
      puts "#{player1_name} and #{player2_name} have the same sign!"
      puts "#{player2_name} please choose another sign. Your new sign is: "
      player2_sign = gets.chomp
    end  
    puts "You have successfully configured the players. Let's start playing!"
    
    @players = [Player.new(player1_name,player1_sign), Player.new(player2_name,player2_sign)]
    @board = Board.new
  end
    
  def start_game
    puts "Choosing random player: "
    starting_player = @players.sample
    puts "Starting player is #{starting_player.name}"
    play_round(starting_player)
  end
          
  def play_round(player)
    @board.show_board
    puts "Current player is: #{player.name} (#{player.sign})"
    @board.update_field(@board.choose_field,player.sign)
    
    if @board.win?(player)
      @board.show_board
      puts "#{player.name} won the game"
    elsif @board.board_full?
      @board.show_board
      puts "Its a draw"
    else
      play_round(@players[@players.index(player)-1]) #Spielerwechsel
    end     
  end
end

tic_tac_toe = Game.new
tic_tac_toe.start_game
