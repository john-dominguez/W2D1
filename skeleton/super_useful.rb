require 'byebug'
# PHASE 2
def convert_to_int(str)
  Integer(str)
rescue ArgumentError => error
    error.message
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

class CoffeeError < StandardError

end


def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise CoffeeError.new("Thanks for the coffeee, but give me some fruits!")
  else
    raise StandardError.new("what the hell is this?")
  end
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

    puts "Feed me a fruit! (Enter the name of a fruit:)"

    maybe_fruit = gets.chomp
    reaction(maybe_fruit)

  rescue CoffeeError => cof
    puts cof.message
    retry
  rescue StandardError => ste
    puts ste.message
end

class FriendshipError < StandardError
end
class NameError < StandardError
end
class PastTimeError < StandardError
end

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    @yrs_known = yrs_known
    raise FriendshipError.new("that's not long enough") if yrs_known < 5
    @fav_pastime = fav_pastime
    raise NameError.new("Best friend must have a name") if name.empty?
    raise PastTimeError.new("This friend must like doing something") if fav_pastime.empty?

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
