# The above can be replaced with whatever language you choose

# Modify this file to create your hangman program.
#
# The input filename will come as an argument (see completeness_test).

require 'byebug'

class Hangman
  attr_accessor :life_left, :word

  def initialize(life_left = 6, word)
    @life_left = 6
    @word = word
    @guessed_word = @word.gsub(/\w/, '_')
    @guessed_chars = []
    
    print_game_status
  end

  def guess(guessed_char)
    @guessed_chars << guessed_char
    @guessed_word = compute_guessed_word

    @life_left -= 1 unless @word.include? guessed_char
  end
  
  # Return the letters that were guess that are not part of the word.
  def incorrect_guesses
    @guessed_chars.join.tr @guessed_word, ''
  end

  def print_game_status
    if won?
      puts "#{@guessed_word} YOU WIN!"
    else
      if @life_left == 0
        puts "#{@guessed_word} YOU LOSE!"
      else
        print "#{@guessed_word} life left: #{@life_left}"
        print " incorrect guesses: #{incorrect_guesses}" unless incorrect_guesses.empty?
        print "\n"
      end
    end
  end

  def won?
    @guessed_word == @word
  end
  
  # Loop through each character in the correct word.
  # If the letter was *NOT* one of the guessed letters, then replace it with a _
  def compute_guessed_word
    @word.chars.map { |c| @guessed_chars.include?(c) ? c : '_' }.join
  end
end

input_filename = ARGV[0]
file = File.new(input_filename)
lines = file.readlines

lines.each do |line|
  skip if line.empty?
  line.chomp!

  if line.length > 1 # word
    @hangman = Hangman.new(6, line) 
  else
    next if @hangman.won?
    @hangman.guess(line)
    @hangman.print_game_status
  end
end
