quiz = Quiz.new(1, "SAMPLE: Should I go out tonight?")

q1 = Question.new(:id => "Q1", :text => "Are you tired?", :answers => {
    "Yes" => "Q2",
    "No" => "Q3"
})

q2 = Question.new(:id => "Q2", :text => "Is the event important?", :answers => {
    "Yes" => "Q4",
    "No" => "R1"
})

q3 = Question.new(:id => "Q3", :text => "Think you'll have fun?", :answers => {
    "Yes" => "R3",
    "Maybe" => "Q5",
    "No" => "Q2"
})

q4 = Question.new(:id => "Q4", :text => "Is this the only time you can go?", :answers => {
    "Yes" => "R2",
    "No" => "Q6"
})

q5 = Question.new(:id => "Q5", :text => "Will you be with friends?", :answers => {
    "Yes" => "R2",
    "No" => "Q6"
})

q6 = Question.new(:id => "Q6", :text => "Will there be free food?", :answers => {
    "Yes" => "R2",
    "No" => "A1"
})

r1 = Result.new(:id => "R1", :text => "Stay In")
r2 = Result.new(:id => "R2", :text => "Go Out")
r3 = Result.new(:id => "R3", :text => "Ya, go out, have a ball!")

quiz.add_question(q1)
quiz.add_question(q2)
quiz.add_question(q3)
quiz.add_question(q4)
quiz.add_question(q5)
quiz.add_question(q6)

quiz.add_result(r1)
quiz.add_result(r2)
quiz.add_result(r3)
