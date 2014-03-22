class Warrior
  DIRECTIONS = [:forward, :left, :right, :backward]

  def initialize(warrior)
    @warrior = warrior
  end

  def play_turn
    rest_if_needed
    search_and_fight_enemies
    walk_to_stairs
  end

  private

  def search_and_fight_enemies
    DIRECTIONS.each do |direction|
      return if turn_finished?

      space = @warrior.feel direction

      if space.enemy?
        @warrior.attack! direction
      end
    end
  end

  def walk_to_stairs
    return if turn_finished?

    space = @warrior.feel @warrior.direction_of_stairs

    if space.enemy?
      @warrior.attack! @warrior.direction_of_stairs
    else
      @warrior.walk! @warrior.direction_of_stairs
      @@last_move = @warrior.direction_of_stairs
    end
  end

  def rest_if_needed
    return if turn_finished?

    if @warrior.health < 4
      if DIRECTIONS.all? { |d| !@warrior.feel(d).enemy? }
        @warrior.rest!
      else
        @warrior.walk! opposite_direction(@@last_move)
      end
    end
  end

  def turn_finished?
    @warrior.instance_variable_get("@action")
  end

  def opposite_direction(direction)
    case direction
    when :forward
      :backward
    when :backward
      :forward
    when :right
      :left
    when :left
      :right
    end
  end
end
