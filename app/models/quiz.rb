class Quiz
  attr_accessor :id, :title, :questions, :answers
  @@all = []
  
  def self.find_by_id(id)
    @@all.detect{|q| q.id.to_s == id.to_s}
  end

  def next_step(step_id)
    if step_id.start_with?("Q")
      find_question(step_id)
    elsif step_id.start_with?("A")
      find_answer(step_id)    
    end
  end

  def find_question(step_id)
    @questions.detect{|q| q.id == step_id}
  end

  def find_answer(step_id)
    @answers.detect{|a| a.id == step_id}
  end

  def initialize(id, title)
    @id = id
    @questions = []
    @answers = []
    @title = title
    save
  end

  def save
    @@all << self
  end
  
  def self.all
    @@all
  end

  def add_question(question)
    self.questions << question
  end

  def add_answer(answer)
    self.answers << answer
  end
end
