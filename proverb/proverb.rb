require 'forwardable'

class Proverb
  attr_reader :nouns, :qualifier

  def initialize(*nouns, qualifier: "")
    @nouns = nouns
    @qualifier = qualifier
  end

  def to_s
    proverb = []

    CauseEffect.from_chain(nouns).each do |cause_effect|
      proverb << consquence_line(cause_effect)
    end

    proverb << original_cause
    proverb.join("\n")
  end

  private

  def nouns
    @nouns
  end

  def consquence_line(cause_effect)
    "For want of a #{cause_effect.cause} the #{cause_effect.effect} was lost."
  end

  def original_cause
    "And all for the want of a #{qualified_noun(nouns.first)}."
  end

  def qualified_noun(noun)
    "#{qualifier} #{noun}".strip
  end
end

class CauseEffect
  attr_reader :cause, :effect

  def self.from_chain(chain)
    cause_effects = []
    0.upto(chain.length - 2).each do |i|
      cause_effects << CauseEffect.new(chain[i], chain[i+1])
    end
    cause_effects
  end

  def initialize(cause, effect)
    @cause = cause
    @effect = effect
  end
end
