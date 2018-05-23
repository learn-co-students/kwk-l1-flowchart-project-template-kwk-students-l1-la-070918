require_relative "spec_helper"


describe 'ApplicationController' do
  before(:each) do
    quiz = Quiz.new(1, "SAMPLE: Should I go out tonight?")

    q1 = Question.new(:id => "Q1", :text => "Are you tired?", :answers => {
        "Yes" => "Q2",
        "No" => "R2"
    })

    q2 = Question.new(:id => "Q2", :text => "Is the event important?", :answers => {
        "Yes" => "R2",
        "No" => "R1"
    })
    r1 = Result.new(:id => "R1", :text => "Stay In")
    r2 = Result.new(:id => "R2", :text => "Go Out")

    quiz.add_question(q1)
    quiz.add_question(q2)

    quiz.add_result(r1)
    quiz.add_result(r2)
  end

  context 'The Homepage - GET /' do
    it 'has an index view in "app/views/index.html.erb"' do
      expect(File.exists?("app/views/index.html.erb")).to be_truthy, "Did you create a view in 'app/views/index.html.erb'?"
    end

    it 'renders the index view' do
      expect_any_instance_of(ApplicationController).to receive(:erb).with(/index/)

      get '/'
    end

    it "responds with a 200 status code" do
      get '/'

      expect(last_response.status).to eq(200), "Something seems broken with the '/' route. The response status code was #{last_response.status}"
    end

    it 'includes a link to the quiz in the index view' do
      visit '/'

      expect(page).to have_link("SAMPLE: Should I go out tonight?", :href => /quiz\/1/), "Did you create a link to the quizzes with the correct HREF in index.html.erb?"
    end
  end

  context 'A Quiz - GET /quiz/:id' do
    it 'loads the quiz from the ID in the URL using Quiz.find_by_id' do
      expect(Quiz).to receive(:find_by_id).with("1"), "Did you call Quiz.find_by_id(params[:id]) in '/quiz/:id'?"

      get '/quiz/1'
    end

    it 'has a quiz view in "app/views/quiz.html.erb"' do
      expect(File.exists?("app/views/quiz.html.erb")).to be_truthy, "Did you create a view in 'app/views/quiz.html.erb'?"
    end

    it 'renders the quiz view' do
      expect_any_instance_of(ApplicationController).to receive(:erb).with(/quiz/)

      get '/quiz/1'
    end

    it "responds with a 200 status code" do
      get '/quiz/1'

      expect(last_response.status).to eq(200), "Something seems broken with the '/quiz/:id' route. The response status code was #{last_response.status}"
    end

    it "includes the first question's text in the HTML" do
      visit '/quiz/1'

      expect(page).to have_text("Are you tired?"), "Did you include the Quiz title in the view quiz.html.erb?"
    end

    context 'The Quiz Form' do
      it "has a form to submit the answer with an action pointing to the /quiz/:id" do
        visit '/quiz/1'

        expect(page).to have_css("form[action*='quiz/1']"), "Did you create a form tag with the appropriate action in quiz.html.erb?"
      end

      it "has radio buttons for each answer" do
        visit '/quiz/1'

        expect(page).to have_field("next_step", :type => 'radio'), "Did you include 'radio' inputs for the question answers with a name of 'next_step?'"
      end

      it "the radio buttons have values for the next step of question" do
        visit '/quiz/1'

        expect(page).to have_field("next_step", :type => 'radio', :with => "Q2"), "Did you fill in the value of the question answers as the value of the radio inputs?"
        expect(page).to have_field("next_step", :type => 'radio', :with => "R2"), "Did you fill in the value of the question answers as the value of the radio inputs?"
      end

      it "has a submit button" do
        visit '/quiz/1'

        expect(page).to have_css("[type='submit']")
      end
    end
  end

  context 'Submittin a Question - POST /quiz/:id' do
    it 'loads the quiz from the ID in the URL using Quiz.find_by_id' do
      expect(Quiz).to receive(:find_by_id).with("1")

      post '/quiz/1', {:next_step => "Q2"}
    end

    it 'loads the next step for the quiz using #next_step and params[:next_step]' do
      expect_any_instance_of(Quiz).to receive(:next_step).with("Q2")

      post '/quiz/1', {:next_step => "Q2"}
    end

    it 'renders the quiz view when next_step is a question' do
      expect_any_instance_of(ApplicationController).to receive(:erb).with(/quiz/)

      post '/quiz/1', {:next_step => "Q2"}
    end

    it 'redirects to /quiz/:id/results/:result_id when the next_step is a result' do
      post '/quiz/1', {:next_step => "R1"}

      expect(last_response).to be_a_redirect
      expect(last_response.location).to include("quiz/1/results/R1")
    end

    context 'Submitting an answer and seeing the next question form' do
      it "has a form to submit the answer with an action pointing to the /quiz/:id" do
        visit '/quiz/1'

        find('input[value="Q2"]').click
        find('[type="submit"]').click

        expect(page).to have_css("form[action*='quiz/1']")
        expect(page).to have_content("Is the event important?")
        expect(page).to have_field("Yes", :type => 'radio', :with => "R2")
        expect(page).to have_field("No", :type => 'radio', :with => "R1")
        expect(page).to have_css("[type='submit']")
      end
    end

    context 'Submitting an answer and seeing the next result' do
      it "has a form to submit the answer with an action pointing to the /quiz/:id" do
        visit '/quiz/1'

        find('input[value="R2"]').click
        find('[type="submit"]').click

        expect(page).to_not have_css("form[action*='quiz/1']")
        expect(page).to_not have_css("[type='submit']")
        expect(page).to have_content("Go Out")
      end
    end
  end
end
