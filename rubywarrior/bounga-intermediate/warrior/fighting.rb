module Fighting
  module ClassMethods

  end

  module InstanceMethods
    def fight_enemies!
      bind_enemy!
      attack_enemy!
      walk_to_enemy!
    end

    private

    def attack_enemy!
      # TODO: Fight weaker first
      return if turn_finished?

      direction = enemies_nearby?

      if direction
        warrior.attack! direction
      end
    end

    def enemies_nearby?
      if enemies.any?
        Constants::DIRECTIONS.find { |direction| warrior.feel(direction).enemy? }
      else
        # Search for captive enemies
        Constants::DIRECTIONS.find do |direction|
          detected = warrior.feel(direction)
          detected.captive? && detected.to_s != "Captive"
        end
      end
    end

    def walk_to_enemy!
      return if turn_finished?

      walk_avoiding_stairs! warrior.direction_of(enemies.first) if enemies.any?
    end

    def bind_enemy!
      return if turn_finished?

      if enemies.count > 2
        enemy = enemies_nearby?
        warrior.bind!(enemy) if enemy
      end
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
