require 'forwardable'

class Proverb
  attr_reader :nouns, :qualifier

  def initialize(*nouns, qualifier: "")
    @nouns = nouns
    @qualifier = qualifier
  end

  def to_s
    proverb = []
    cause_effects = CauseEffect.new(nouns)
    cause_effects.each do |cause_effect|
      proverb << consquence_line(cause_effect[:cause], cause_effect[:effect])
    end

    proverb << original_cause
    proverb.join("\n")
  end

  private

  def nouns
    @nouns
  end

  def consquence_line(want, lost)
    "For want of a #{want} the #{lost} was lost."
  end

  def original_cause
    "And all for the want of a #{qualified_noun(nouns.first)}."
  end

  def qualified_noun(noun)
    "#{qualifier} #{noun}".strip
  end
end

class CauseEffect
  extend Forwardable

  def_delegators :pairs, :each

  def initialize(*chain_of_events)
    @pairs = []
    create_pairs(*chain_of_events)
  end

  private

  def pairs
    @pairs
  end

  def create_pairs(chain_of_events)
    index = 0
    while index < chain_of_events.length - 1
      pairs << {cause: chain_of_events[index], effect: chain_of_events[index + 1]}
      index += 1
    end
  end

end
