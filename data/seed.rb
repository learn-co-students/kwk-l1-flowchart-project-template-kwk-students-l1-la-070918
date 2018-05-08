quiz = Quiz.new(1, "Should I go out tonight?")

q1 = Question.new(:id => "Q1", :text => "Are you tired?", :answers => {
    "Yes" => "Q2",
    "No" => "Q3"
})

q2 = Question.new(:id => "Q2", :text => "Is the event important?", :answers => {
    "Yes" => "Q4",
    "No" => "A1"
})

q3 = Question.new(:id => "Q3", :text => "Think you'll have fun?", :answers => {
    "Yes" => "A3",
    "Maybe" => "Q5",
    "No" => "Q2"
})

q4 = Question.new(:id => "Q4", :text => "Is this the only time you can go?", :answers => {
    "Yes" => "A2",
    "No" => "Q6"
})

q5 = Question.new(:id => "Q5", :text => "Will you be with friends?", :answers => {
    "Yes" => "A2",
    "No" => "Q6"
})

q6 = Question.new(:id => "Q6", :text => "Will there be free food?", :answers => {
    "Yes" => "A2",
    "No" => "A1"
})

a1 = Answer.new(:id => "A1", :text => "Stay In")
a2 = Answer.new(:id => "A2", :text => "Go Out")
a3 = Answer.new(:id => "A3", :text => "Ya, go out, have a ball!")

quiz.add_question(q1)
quiz.add_question(q2)
quiz.add_question(q3)
quiz.add_question(q4)
quiz.add_question(q5)
quiz.add_question(q6)

quiz.add_answer(a1)
quiz.add_answer(a2)
quiz.add_answer(a3)