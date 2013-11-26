class Sentence
  def initialize
  end

  def to_s
    (["blah"] * 20).join(' ') + "."
  end
end

class Paragraph
  attr_accessor :goal
  attr_accessor :characters
  attr_accessor :item
  attr_accessor :sentences

  def initialize(goal, characters, item)
    @goal, @characters, @item =
      goal, characters, item
    @sentences = []
  end

  def to_s
    @goal.upcase +
      "\n" +
      @sentences.map { |sentence| sentence.to_s }.join(' ')
  end

  def create!
    @sentences.clear
    num = rand(18) + 3
    num.times { @sentences << Sentence.new }
  end
end

class Chapter
  PARAGRAPHS = [
    { goal: 'introduction', min: 1, max: 1 },
    { goal: ['dialogue', 'action', 'description'], min: 3, max: 18 },
    { goal: 'conclusion', min: 1, max: 1 },
  ]

  attr_accessor :goal
  attr_accessor :location
  attr_accessor :characters
  attr_accessor :items
  attr_accessor :paragraphs

  def initialize(goal, location, characters, items)
    @goal, @location, @characters, @items =
      goal, location, characters, items
    @paragraphs = []
  end

  def to_s
    @goal.upcase +
      "\n" +
      "  location: #{@location}\n" +
      "  characters: #{@characters.join(', ')}\n" +
      "  items: #{@items.join(', ')}\n" +
      "\n" +
      @paragraphs.map { |paragraph| paragraph.to_s }.join("\n\n")
  end

  def create!
    @paragraphs.clear
    PARAGRAPHS.each do |paragraph|
      num = paragraph[:min] + rand(paragraph[:max] - paragraph[:min] + 1)
      num.times do
        goal = paragraph[:goal]
        goal = goal.sample if goal.is_a?(Array)
        @paragraphs << _new_paragraph(goal)
      end
    end
    @paragraphs.each { |paragraph| paragraph.create! }
  end

  private

  def _new_paragraph(goal)
    Paragraph.new(goal, [], "")
  end
end

class Story
  # TODO: constrain locations+characters
  # TODO: constrain chapters+locations
  # TODO: feelings about items too
  # TODO: feelings translate into words

  CHAPTERS = [
    { goal: 'stasis', min: 1, max: 3 },
    { goal: 'trigger', min: 1, max: 1 },
    { goal: 'quest', min: 1, max: 2 },
    { goal: 'surprise', min: 3, max: 7 },
    { goal: 'choice', min: 1, max: 1 },
    { goal: 'climax', min: 1, max: 2 },
    { goal: 'reversal', min: 1, max: 2 },
    { goal: 'resolution', min: 1, max: 3 },
  ]

  CHARACTERS = [
    { role: 'hero', min: 1, max: 1 },
    { role: 'nemesis', min: 1, max: 1 },
    { role: 'mentor', min: 1, max: 1 },
    { role: 'mentee', min: 1, max: 1 },
    { role: 'lover', min: 1, max: 1 },
    { role: 'ally', min: 0, max: 3 },
    { role: 'enemy', min: 0, max: 3 }
  ]

  RELATIONSHIPS = {
    hero: {
      nemesis: 'hate',
      mentor: 'respect',
      mentee: 'kindness',
      lover: 'love',
      ally: 'respect',
      enemy: 'hate'
    },
    nemesis: {
      hero: 'hate',
      mentor: 'hate',
      mentee: 'kindness',
      lover: 'love',
      ally: 'hate',
      enemy: 'kindness'
    },
    mentor: {
      hero: 'kindness',
      nemesis: 'hate',
      mentee: 'kindness',
      lover: 'respect',
      ally: 'kindness',
      enemy: 'hate'
    },
    mentee: {
      hero: 'love',
      nemesis: 'respect',
      mentor: 'respect',
      lover: 'respect',
      ally: 'kindness',
      enemy: 'fear'
    },
    lover: {
      hero: 'love',
      nemesis: 'fear',
      mentor: 'kindness',
      mentee: 'kindness',
      ally: 'kindness',
      enemy: 'fear'
    },
    ally: {
      hero: 'love',
      nemesis: 'fear',
      mentor: 'respect',
      mentee: 'kindness',
      lover: 'respect',
      enemy: 'fear'
    },
    enemy: {
      hero: 'hate',
      nemesis: 'love',
      mentor: 'hate',
      mentee: 'kindness',
      lover: 'kindness',
      ally: 'fear'
    }
  }

  LOCATIONS = [
    { role: 'home', min: 1, max: 1 },
    { role: 'lair', min: 1, max: 1 },
    { role: 'goal', min: 1, max: 1 },
    { role: 'waypoint', min: 1, max: 4 }
  ]

  ITEMS = [
    { role: 'ring', min: 1, max: 1 },
    { role: 'trinket', min: 1, max: 6 },
    { role: 'curse', min: 1, max: 1 }
  ]

  attr_accessor :chapters

  def initialize(world)
    @world = world
    @characters = []
    @locations = []
    @items = []
    @chapters = []
  end

  def to_s
    @chapters.map { |chapter| chapter.to_s }.join("\n\n---\n\n")
  end

  def create!
    @characters.clear
    CHARACTERS.each do |character|
      num = character[:min] + rand(character[:max] - character[:min] + 1)
      num.times { @characters << @world.new_character(character[:role]) }
    end
    @locations.clear
    LOCATIONS.each do |location|
      num = location[:min] + rand(location[:max] - location[:min] + 1)
      num.times { @locations << @world.new_location(location[:role]) }
    end
    @items.clear
    ITEMS.each do |item|
      num = item[:min] + rand(item[:max] - item[:min] + 1)
      num.times { @items << @world.new_item(item[:role]) }
    end
    @chapters.clear
    CHAPTERS.each do |chapter|
      num = chapter[:min] + rand(chapter[:max] - chapter[:min] + 1)
      num.times { @chapters << _new_chapter(chapter[:goal]) }
    end
    @chapters.each { |chapter| chapter.create! }
  end

  private

  def _new_chapter(goal)
    # TODO: restrict character / item / location based on chapter goal
    num_characters = 2 + rand(2)
    num_items = 1 + rand(2)
    Chapter.new(goal, @locations.sample, @characters.sample(num_characters), @items.sample(num_items))
  end
end
