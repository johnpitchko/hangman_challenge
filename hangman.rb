# The above can be replaced with whatever language you choose

# Modify this file to create your hangman program.
#
# The input filename will come as an argument (see completeness_test).

class Hangman
  attr_accessor :life_left, :word

  def initialize(life_left = 6, word)
    @life_left = 6
    @word = word
    @guessed_word = @word.gsub(/\w/, '_')
    @guessed_chars = []
    
    @word.length.times { print '_' }
    print "life left: #{@life_left}\n"
  end

  def guess(guessed_char)
    @guessed_chars << guessed_char

    if @word.include? guessed_char
      update_guessed_word 
    else
      @life_left -= 1
    end
  end

  def won?
    if @guessed_word == @word
      puts "#{@guessed_word} YOU WIN!"
      true
    else
      if @life_left == 0
        puts "#{@guessed_word} YOU LOSE!"
      else
        print "#{@guessed_word} life left: #{@life_left}\n"
      end
      false
    end
  end
  
  def update_guessed_word
    chars = @word.split('')

    chars.map! do |char|
      unless @guessed_chars.include?(char)
        '_'
      else
        char
      end
    end

    @guessed_word = chars.join
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
    @hangman.guess(line)
    @hangman.won?
  end
end
