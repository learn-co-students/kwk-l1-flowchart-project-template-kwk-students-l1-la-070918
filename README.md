

Should you go out tonight?

1. Are you tired?

A. Yes -> 2A
B. No -> 2B

Question.new(:id => "1", :text => "Are you tired?", :answers => {
    "Yes" => "2A"
    "No" => "2B"
})

2A. Is the event important?

Question.new(:id => "2A", :text => "Is the event important?", :answers => {
    "Yes" => "3A"
    "No" => "A1"
})

A. Yes -> 3A
B. No -> Stay In

2B. Think you'll have fun?

A. Yes -> Go out
B. Maybe -> 3A
C. No -> 3A

Question.new(:id => "2A", :text => "Is the event important?", :answers => {
    "Yes" => "A2",
    "Maybe" => "Q3A",
    "No" => "2A"
})

3A. Is this the only time you can go?

A. Yes -> Go out
B. No -> Stay in

Answer.new(:id => "A1", :text => "Stay In")
