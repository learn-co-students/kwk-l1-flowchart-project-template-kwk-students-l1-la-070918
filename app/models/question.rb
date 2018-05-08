class Question
  attr_accessor :id, :text, :answers

  def initialize(data = {})
    @id = data[:id]
    @text = data[:text]
    @answers = data[:answers]
  end

end