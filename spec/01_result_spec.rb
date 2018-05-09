require_relative "spec_helper"

RSpec.describe "app/models/result.rb" do

  it 'defines an Result class' do
    expect(defined?(Result)).to be_truthy, "Did you define an Result class in app/models/result.rb?"
    expect(Result).to be_a(Class), "Did you define an Result class in app/models/result.rb?"
  end

end
