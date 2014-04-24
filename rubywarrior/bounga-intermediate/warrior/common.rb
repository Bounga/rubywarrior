module Common
  module ClassMethods

  end

  module InstanceMethods
    attr_accessor :warrior, :captives, :enemies

    def play_turn
      # Analysing environment
      map_level

      # Always rest first if needed
      rest_if_needed!

      # Rescue captives
      rescue_captives!

      # If no captives left, fight enemies
      fight_enemies!

      # Nothing left, we can leave
      walk_to_stairs!
    end

    def turn_finished?
      warrior.instance_variable_get("@action")
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
