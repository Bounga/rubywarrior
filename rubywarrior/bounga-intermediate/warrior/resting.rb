module Resting
  module ClassMethods

  end

  module InstanceMethods
    def rest_if_needed!
      return if turn_finished?

      if warrior.health <= Constants::CRITICAL_HEALTH
        if enemies_nearby?
          warrior.walk! safe_space_direction
        else
          warrior.rest!
        end
      end
    end

    private

    def safe_space_direction
      Constants::DIRECTIONS.find { |direction| warrior.feel(direction).empty? }
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
