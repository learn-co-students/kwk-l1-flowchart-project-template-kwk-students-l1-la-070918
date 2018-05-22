require_relative "spec_helper"

RSpec.describe "app/models/quiz.rb" do

  it 'defines an Quiz class' do
    expect(defined?(Quiz)).to be_truthy, "Did you define an Quiz class in app/models/quiz.rb?"
    expect(Quiz).to be_a(Class), "Did you define an Quiz class in app/models/quiz.rb?"
  end

  it 'requires an ID and TITLE attribute on initialization' do
    expect{Quiz.new()}.to raise_error(ArgumentError), "Does initialize on quiz accept 2 arguments?"
    q = Quiz.new("1", "Should I go out tonight?")

    expect(q).to respond_to(:id, :id=), "Did you set an attr_accessor of :id?"
    expect(q).to respond_to(:title, :title=), "Did you set an attr_accessor of :id?"

    expect(q.id).to eq("1"), "Did you set @id to the first argument of initialize?"
    expect(q.title).to eq("Should I go out tonight?"), "Did you set @title to the first argument of initialize?"
  end

  it 'has attributes of questions and results' do
    q = Quiz.new("1", "Should I go out tonight?")
    expect(q).to respond_to(:questions, :questions=)
    expect(q).to respond_to(:results, :results=)
  end

  it 'has initializes questions and results to empty arrays' do
    q = Quiz.new("1", "Should I go out tonight?")
    expect(q.questions).to eq([])
    expect(q.results).to eq([])
  end

  it 'persists new instances into a class variable @@all upon initialization' do
    q = Quiz.new("1", "Should I go out tonight?")

    expect(Quiz.class_variable_get(:@@all)).to include(q)
  end

  it 'exposes the instances in class variable @@all through a class method Quiz.all' do
    q = Quiz.new("1", "Should I go out tonight?")
    Quiz.class_variable_set(:@@all, [q])

    expect(Quiz.all).to include(q)
  end

  it 'has a class method to find instances by id' do
    q = Quiz.new("1", "Should I go out tonight?")
    q2  = Quiz.new("2", "What should I wear?")

    expect(Quiz.find_by_id(1)).to eq(q)
  end

  it 'can add questions to @questions through #add_question' do
    q = Quiz.new("1", "Should I go out tonight?")
    q.add_question({})

    expect(q.questions).to include({})
  end

  it 'can add results to @results through #add_result' do
    q = Quiz.new("1", "Should I go out tonight?")
    q.add_result({})

    expect(q.results).to include({})
  end

  it 'can find questions by id through #find_question' do
    q = Quiz.new("1", "Should I go out tonight?")
    question = Question.new({:id => 7})

    q.add_question(question)

    expect(q.find_question(7)).to eq(question)
  end

  it 'can find results by id through #find_result' do
    q = Quiz.new("1", "Should I go out tonight?")
    result = Result.new({:id => 7})

    q.add_result(result)

    expect(q.find_result(7)).to eq(result)
  end

  it 'provides the next step for a question' do
    quiz = Quiz.new("1", "Should I go out tonight?")
    q1 = Question.new({:id => "Q1"})
    q2 = Question.new({:id => "Q2"})

    quiz.add_question(q1)
    quiz.add_question(q2)

    expect(quiz.next_step("Q2")).to eq(q2)
  end

  it 'provides the next step for a result' do
    quiz = Quiz.new("1", "Should I go out tonight?")
    r1 = Result.new({:id => "R1"})
    r2 = Result.new({:id => "R2"})

    quiz.add_result(r1)
    quiz.add_result(r2)

    expect(quiz.next_step("R2")).to eq(r2)
  end
end
