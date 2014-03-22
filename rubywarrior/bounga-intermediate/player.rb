require "warrior"

class Player
  def play_turn(warrior)
    Warrior.new(warrior).play_turn
  end
end
