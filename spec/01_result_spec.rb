require_relative "spec_helper"

RSpec.describe "app/models/result.rb" do

  it 'defines an Result class' do
    expect(defined?(Result)).to be_truthy, "Did you define an Result class in app/models/result.rb?"
    expect(Result).to be_a(Class), "Did you define an Result class in app/models/result.rb?"
  end

  it 'has an id and text attribute' do
    r = Result.new
    r.id = "R1"
    r.text = "Go out!"

    expect(r.id).to eq("R1"), "Did you create an attribute for id with attr_accessor :id?"
    expect(r.text).to eq("Go out!"), "Did you create an attribute for text with attr_accessor :text?"
  end

  it 'can accept a hash of attributes upon initialization' do
    r = Result.new({
        :id => "R1",
        :text => "Go out!"
    })

    expect(r.id).to eq("R1"), "Did you assign the key :id to @id upon initialization?"
    expect(r.text).to eq("Go out!"), "Did you assign the key :text to @text upon initialization?"
  end

end
