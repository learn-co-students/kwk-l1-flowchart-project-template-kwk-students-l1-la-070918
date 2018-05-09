require_relative "spec_helper"

RSpec.describe "app/models/answer.rb" do

  it 'defines an Answer class' do
    expect(defined?(Answer)).to be_truthy, "Did you define an Answer class in app/models/answer.rb?"
    expect(Answer).to be_a(Class), "Did you define an Answer class in app/models/answer.rb?"
  end

end