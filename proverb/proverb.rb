require 'forwardable'

class Proverb
  attr_reader :objects_of_desire, :qualifier

  def initialize(*objects_of_desire, qualifier: "")
    @objects_of_desire = objects_of_desire
    @qualifier = qualifier
  end

  def to_s
    lines = []
    consequences = Consequence.from_list(objects_of_desire)
    consequences.each do |consequence|
      lines << consequence.to_s
    end

    lines << RootCause.new(objects_of_desire.first, qualifier).to_s
    lines.join("\n")
  end

  private

  def objects_of_desire
    @objects_of_desire
  end
end

class RootCause
  attr_reader :object_of_desire, :qualifier

  def initialize object_of_desire, qualifier
    @object_of_desire = object_of_desire
    @qualifier = qualifier
  end

  def to_s
    "And all for the want of a #{qualified_object}."
  end

  private

  def qualified_object
    "#{qualifier} #{object_of_desire}".strip
  end
end

class Consequence
  def self.from_list(objects)
    consequences = []

    0.upto(objects.length - 2).each do |i|
      consequences << self.new(objects[i], objects[i + 1])
    end
    consequences
  end

  def initialize(wanted_object, lost_object)
    @wanted_object = wanted_object
    @lost_object = lost_object
  end

  def to_s
     "For want of a #{wanted_object} the #{lost_object} was lost."
  end

  private

  def wanted_object
    @wanted_object
  end

  def lost_object
    @lost_object
  end
end
