class Proverb
  attr_reader :nouns, :qualifier

  def initialize(*nouns, qualifier: "")
    @nouns = nouns
    @qualifier = qualifier
  end

  def to_s
    lines = []
    0.upto(nouns.length - 1) do |i|
      lines << line(i)
    end
    lines.join("\n")
  end

  private

  def line(line_number)
    if line_number < nouns.length - 1
      consquence_line(nouns[line_number], nouns[line_number + 1])
    else
      original_cause
    end
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
