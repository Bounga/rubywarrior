class Player
  def play_turn(warrior)
    space = warrior.feel warrior.direction_of_stairs

    if space.enemy?
      warrior.attack! warrior.direction_of_stairs
    else
      warrior.walk! warrior.direction_of_stairs
    end
  end
end
