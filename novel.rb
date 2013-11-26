class Novel
  attr_accessor :title
  attr_accessor :author
  attr_accessor :text

  def initialize(model, story)
    @model, @story = model, story
  end

  def write!
    # generate title
    # generate author
    # generate text
  end

  def publish!
    # create LaTeX document
  end
end

__END__
Constrained Illiteral Ramblings
===============================

A Novel
-------

### By M.G.

CHAPTER ONE
-----------

_Some kind of overview_

Content

CHAPTER TWO
-----------

...
