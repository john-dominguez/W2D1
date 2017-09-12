require 'byebug'
require_relative 'super_useful'

# puts "'five' == #{convert_to_int('five')}"

# feed_me_a_fruit

sam = begin
  BestFriend.new('', 5, '')
rescue FriendshipError => e
  puts e.message
end

# sam.talk_about_friendship
# sam.do_friendstuff
# sam.give_friendship_bracelet
