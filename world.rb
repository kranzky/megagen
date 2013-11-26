class Character
  attr_accessor :name
  attr_accessor :role
  attr_accessor :sex

  def initialize(role)
    @role = role
    @name = "CH_" + @role + "-" + ('a'..'z').to_a.sample(6).join
  end

  def to_s
    @name
  end
end

class Location
  attr_accessor :name
  attr_accessor :role

  def initialize(role)
    @role = role
    @name = "LO_" + @role + "-" + ('a'..'z').to_a.sample(6).join
  end

  def to_s
    @name
  end
end

class Item
  attr_accessor :name
  attr_accessor :role

  def initialize(role)
    @role = role
    @name = "OB_" + @role + "-" + ('a'..'z').to_a.sample(6).join
  end

  def to_s
    @name
  end
end

class World
  attr_accessor :characters
  attr_accessor :locations
  attr_accessor :items

  def initialize(model)
    @model = model
  end

  # populate the world with characters, locations, items and events
  def build!
    # generate characters
    # generate locations
    # generate items
  end

  def new_character(role)
    Character.new(role)
  end

  def new_location(role)
    Location.new(role)
  end

  def new_item(role)
    Item.new(role)
  end

end
