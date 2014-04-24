module Rescuing
  module ClassMethods

  end

  module InstanceMethods
    def rescue_captives!
      unbind_captive!
      walk_to_captives!
    end

    private

    def unbind_captive!
      return if turn_finished?

      direction = captives_nearby?
      if direction
        warrior.rescue! direction
      end
    end

    def walk_to_captives!
      return if turn_finished?

      captive = captives.find { |c| c.to_s == "Captive" }

      if captive
        direction = warrior.direction_of(captive)

        if warrior.feel(direction).enemy?
          # Captive guarded by an enemy
          warrior.attack! direction
        else
          walk_avoiding_stairs! warrior.direction_of(captive)
        end
      end
    end

    def captives_nearby?
      Constants::DIRECTIONS.find do |direction|
        detected = warrior.feel(direction)
        detected.captive? && detected.to_s == "Captive"
      end
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
