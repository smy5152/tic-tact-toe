# !/usr/bin/env ruby

# require_relative '../lib/tic_tac_toe'
require_relative "../lib/tic_tac_toe/player"

# Use getters to collect input from players
puts "Let's play tic-tac-toe!"
puts 'Enter your name player one'
name = 'ABC' # gets.chomp
player_one = name
puts "Welcome #{player_one}, select either 'X' or 'O' as your marker"
marker = 'X' # gets.chomp.upcase

# Validate input from the players
def validate_marker(player_one, marker)
  game_markers = %w[X O]
  unless game_markers.include? marker
    puts "Oops! Wrong input. Select either 'X' or 'O' as your marker"
    marker = gets.chomp.upcase
  end
  "#{player_one} selects #{marker}"
end

puts validate_marker(player_one, marker)

# Create Player 1 object
player_1_Obj = Player.new(player_one, marker, Array.new(9, 0))

def change_marker(marker)
  other_marker = %w[X O].reject { |ch| ch == marker }
  other_marker[0]
end

puts 'Enter your name player two'
name = 'XYZ' # gets.chomp
player_two = name

# Create Player 2 object
player_2_Obj = Player.new(player_two, change_marker(marker), Array.new(9, 0))

puts "Welcome #{player_2_Obj.name}, your marker is #{player_2_Obj.marker}"


puts 'Remember: The player with a row, column or diagonal of the same marker wins'
puts "Ready? Let's begin!"

# Define the board layout
def board(moved_cells = %w[1 2 3 4 5 6 7 8 9])
  cells = moved_cells
  puts 'Enter a number between 1 - 9 to select a position for your marker'
  puts <<-GRID

                #{cells[0]} | #{cells[1]} | #{cells[2]}
               ---+---+---
                #{cells[3]} | #{cells[4]} | #{cells[5]}
               ---+---+---
                #{cells[6]} | #{cells[7]} | #{cells[8]}

  GRID
end

def accept_moves(player_one, player_two)
  cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  # count_unless_winning_combo = 1
  move = 0
  moves_done = 1
  board(cells)
  while cells.any? { |n| n.is_a? Integer }
    puts 'Select a number from the GRID to make your move.'
    
    puts "#{player_one.name}'s Turn : "
    move_pos = gets.chomp.to_i-1
    while (position_available(move_pos, player_one, player_two)) == false
      puts "Oops! Invalid input. Try Again."
      move_pos = gets.chomp.to_i-1
    end
    # accept player 1 move
    player_one.moves_arr[move_pos] = 1
    # p player_one.moves_arr

    # reference player_object.marker for DISPLAY GRID
    cells[move_pos] = player_one.marker

    board(cells)

    unless board_is_full(cells)
      puts 'Select a number from the GRID to make your move.'
      # accept player 2 move
      puts "#{player_two.name}'s Turn : "
      move_pos = gets.chomp.to_i-1
      while (position_available(move_pos, player_one, player_two)) == false
        puts "Oops! Invalid input. Try Again."
        move_pos = gets.chomp.to_i-1
      end 
      # accept player 2 move
      player_two.moves_arr[move_pos] = 1
      # reference player_object.marker
      cells[move_pos] = player_two.marker

      board(cells)
    end

    break if moves_done > 8 == true

    moves_done += 1
  end

  puts "#{player_one} Wins!!! Or Draw"
end

def board_is_full(cells)
  return true if cells.count { |x| x.is_a? Integer }.zero?

  false
end

# checks moves array for Player 1 & 2
# allow move position & returns true
# checks against moves array of both players
def position_available(move_pos, player_1_Obj, player_2_Obj)
  p "player1:",player_1_Obj.moves_arr
  p "player2:",player_2_Obj.moves_arr
  if ((player_1_Obj.moves_arr[move_pos] == 0) && (player_2_Obj.moves_arr[move_pos] == 0)) == true
          return true
  end
  return false
end

accept_moves(player_1_Obj, player_2_Obj)
