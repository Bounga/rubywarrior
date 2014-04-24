require "warrior/constants"
require "warrior/common"
require "warrior/mapping"
require "warrior/resting"
require "warrior/rescuing"
require "warrior/fighting"
require "warrior/escaping"

class Warrior
  include Constants
  include Common
  include Mapping
  include Resting
  include Rescuing
  include Fighting
  include Escaping

  def initialize(warrior)
    self.warrior = warrior
  end
end
