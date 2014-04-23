require 'pp'
class Warrior
  DIRECTIONS    = [:forward, :left, :right, :backward].freeze
  CRITIC_HEALTH = 8.freeze

  def initialize(warrior)
    @warrior  = warrior
    @enemies  = []
    @captives = []
  end

  def play_turn
    feel_spaces
    rest_if_needed!
    rescue_captives!
    bind_enemy!
    fight_enemies!
    walk_to_stairs!
  end

  private

  def feel_spaces
    DIRECTIONS.each do |direction|
      something = @warrior.feel(direction)

      if something
        case
        when something.enemy? || something.unit.is_a?(RubyWarrior::Units::Sludge)
          @enemies << direction
        when something.captive?
          @captives << direction
        end
      end
    end
  end

  def rest_if_needed!
    return if turn_finished?

    if @warrior.health <= CRITIC_HEALTH
      if @enemies.empty?
        @warrior.rest!
      else
        @warrior.walk! empty_spaces.first
      end
    end
  end

  def bind_enemy!
    return if turn_finished?

    if @enemies.count > 2
      enemy = @enemies.first
      @warrior.bind!(enemy) unless @warrior.feel(enemy).captive?
    end
  end

  def rescue_captives!
    return if turn_finished?

    if @captives.any?
      @warrior.rescue! @captives.first
    end
  end

  def fight_enemies!
    return if turn_finished?

    if @enemies.any?
      @warrior.attack! @enemies.first
    end
  end

  def walk_to_stairs!
    return if turn_finished?

    @warrior.walk! @warrior.direction_of_stairs
  end

  def turn_finished?
    @warrior.instance_variable_get("@action")
  end

  def empty_spaces
    DIRECTIONS - @enemies - @captives
  end
end
