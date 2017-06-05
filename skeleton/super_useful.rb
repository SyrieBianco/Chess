# PHASE 2
def convert_to_int(str)
  Integer(str)
rescue ArgumentError
    nil
end
class NotFruitButCoffeeError < StandardError
end
class NotFruitError < StandardError
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == 'coffee'
    raise NotFruitButCoffeeError
  else
    raise NotFruitError
  end
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"
  begin
  puts "Feed me a fruit! (Enter the name of a fruit:)"
  maybe_fruit = gets.chomp
  reaction(maybe_fruit)
  rescue NotFruitButCoffeeError
    puts 'Coffee is great, but seriously it\'s not a fruit. Maybe where you come from. Please give me a fruit.'
    retry
  rescue NotFruitError
    puts 'Wow you suck at picking fruits. Go away.'
  end
end
# PHASE 4
class TotsNotFriendsError < StandardError
end

class TooShortMoreInfoError < StandardError
end

class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime
    raise TotsNotFriendsError if yrs_known < 5
    raise TooShortMoreInfoError if @name.length == 0 || @fav_pastime.length == 0
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me."
  end
end
