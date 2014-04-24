module Escaping
  module ClassMethods

  end

  module InstanceMethods
    def walk_to_stairs!
      return if turn_finished?

      warrior.walk! warrior.direction_of_stairs
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
