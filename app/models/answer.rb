class Answer
  attr_accessor :id, :text

  def initialize(data = {})
    @id = data[:id]
    @text = data[:text]
  end
  
end