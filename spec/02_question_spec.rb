require_relative "spec_helper"

RSpec.describe "app/models/question.rb" do

  it 'defines an Question class' do
    expect(defined?(Question)).to be_truthy, "Did you define an Question class in app/models/question.rb?"
    expect(Question).to be_a(Class), "Did you define an Question class in app/models/question.rb?"
  end

  it 'has an id, text, and answers attributes' do
    q = Question.new

    q.id = "Q1"
    q.text = "Are you tired?"
    q.answers = {
      "Yes" => "Q2",
      "No" => "Q3",
    }

    expect(q.id).to eq("Q1"), "Did you create an attribute for id with attr_accessor :id?"
    expect(q.text).to eq("Are you tired?"), "Did you create an attribute for text with attr_accessor :text?"
    expect(q.answers).to eq({
      "Yes" => "Q2",
      "No" => "Q3",
    }), "Did you create an attribute for answers with attr_accessor :answers?"
  end

  it 'can accept a hash of attributes upon initialization' do
    r = Question.new({
        :id => "Q1",
        :text => "Are you tired?",
        :answers => {
          "Yes" => "Q2",
          "No" => "Q3",
        }
    })

    expect(r.id).to eq("Q1"), "Did you assign the key :id to @id upon initialization?"
    expect(r.text).to eq("Are you tired?"), "Did you assign the key :text to @text upon initialization?"
    expect(r.answers).to eq({
      "Yes" => "Q2",
      "No" => "Q3",
    }), "Did you assign the key :answers to @answers upon initialization?"
  end

end
