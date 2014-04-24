module Mapping
  module ClassMethods

  end

  module InstanceMethods
    def map_level
      map_captives
      map_enemies
    end

    private

    def map_captives
      self.captives = warrior.listen.select { |space| space.captive? }
    end

    def map_enemies
      self.enemies = warrior.listen.select { |space| space.enemy? }
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
