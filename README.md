# Kode with Klossy  - Flowchart Application Project

<img src="https://cl.ly/rQb8/Image%202018-05-08%20at%209.16.17%20AM.png" align="right" hspace="10" vspace="10" width="250">

## Overview

One of your final projects can be a "Flowchart" style application that can lead a person down a [decision tree](https://www.pinterest.com/pin/125819383316124395/).

You can build all sorts of useful applications with this model, from helping someone pick a major in college, to deciding whether you should have another cookie (yes. always.), to knowing whether your friend might need help, to all sorts of use-cases. That's what makes this type of project fun, once you get the framework of the code working, you can add your own content and help people make better decisions.

You can see a sample version of this application that will help you decide ["Should You Got Out Tonight"](https://blooming-forest-38924.herokuapp.com/quiz/1)

## Concept

[Flowcharts](https://en.wikipedia.org/wiki/Flowchart) or "Decision Trees" work by posing a question to a person and based on the answer they give, leading them to another question, until finally, you have a resolution.

For now, don't worry about the content or domain of your flow chart, you first have to implement the framework of code to handle this style of application.

## Model Framework

This Sinatra Application follows the MVC pattern. Your first job is to implement the models for this application.

### `app/models/result.rb`

The `Result` class will define the "result" of the decision tree. If you built a tree of questions in a quiz to figure out "Should you go out tonight?", possible instances of results for this might be "Yes" or "No"

To setup your `Result` class, follow the tests in the project template to build a class with two attributes, `id`, and `text`.

Additionally, the `initialize` method should take a hash as an argument and expect to set the `@id` and `@text` values of the instance from keys corresponding keys in the hash.

```ruby
yes_result = Result.new(:id => "R1", :text => "Yes, go out.")
no_result = Result.new(:id => "R2", :text => "No, don't go out.")
```

The `id` attribute of the result is an important pattern in this application. It must start with the letter 'R' and be unique, only one result may have an id of `R1`. We'll be using this unique identifier to find the result of the decision tree.

### `app/models/question.rb`

The 'Question' class will define the questions within the decision tree. For example, a question you might ask to figure out if a person should go out tonight might be, "Are you tired?" This question will have answers in the form of a hash that point to the next question or the result of the decision.

```ruby
question_1 = Question.new
question_1.id = "Q1"
question_1.text = "Are you tired?"
question_1.answers = {
  "Yes" => "R2",
  "No" => "Q2"
}
```

This question instance would be the first question in the decision tree, "Are you tired?". The the possible answers for the question are in the form of a hash, where the key of the hash is the answer's text, and the value of that key, is pointing to the next step of the decision tree. Our HTML will provide to answers to the question, the first one, "Yes", the second one, "No". If the person selects "Yes", our application will direct them to "R1", or result one, telling them, "No, don't go out." If they select "No", our application will continue them to "Q2", or the second question.

Rather than manually assign these attributes when we build questions, we'll also have the Question class accept these upon initialization in the following pattern.

```ruby
question_1 = Question.new(:id => "Q1", :text => "Are you tired?", :answers => {
    "Yes" => "R2",
    "No" => "Q2"
})
```

Question initialization accepts a hash where the keys are the instance's attributes, `id`, `text`, and `answers`.

### `app/models/quiz.rb`

The `Quiz` class represents a decision tree that our application can provide, like "Should I go out tonight?". With this framework, our application could provide multiple trees, not just "Should I go out tonight?" but maybe also "What should I wear tonight?". The `Quiz` class brings together all the questions and results and provides the functionality to navigate the person through the questions and provide a result.

Quizzes have 4 attributes, `id`, `title`, `questions`, `results`.

`id` should be a unique identifier in the form of an integer, like `1`.

`title` is the string title of the decision tree, like "Should I go out tonight?"

`questions` will be an array holding onto the question instances of the quiz.

`results` will be an array holding onto the possible results for the quiz.

Quizzes should accept the `id` and `title` upon initialization. Additionally, when a quiz is initialized, you'll have to set the `questions` and `results` attributes to an empty array, preparing them to store that data.

Finally, our application must remember the quizzes we create, so we'll be using a class variable, `@@all` to `save` the quiz instances when they are initialized.


```ruby
quiz = Quiz.new(1, "Should I go out tonight?")
```

The `Quiz` class will provide two class methods, `Quiz.all`, returning all instances of quizzes that were created, and `Quiz.find_by_id`, which should accept a string or integer and return the quiz instance that matches that `id`.

```ruby
quiz = Quiz.new(1, "Should I go out tonight?")

Quiz.all #=> [#<Quiz @id=1, @title="Should I go out tonight?">]

Quiz.find_by_id("1") #=> #<Quiz @id=1, @title="Should I go out tonight?">
Quiz.find_by_id("X") #=> nil
```

You will also need to implement two methods to allow you to add results and questions to a quiz, `#add_result` and `#add_question`. All these methods need to do is push the result instance or the question instance into the corresponding attribute of the Quiz.

```ruby
quiz = Quiz.new(1, "Should I go out tonight?")

question_1 = Question.new(:id => "Q1", :text => "Are you tired?", :answers => {
    "Yes" => "R2",
    "No" => "Q2"
})
quiz.add_question(question_1)
quiz.questions #=> [#<Question @id="Q1">]

yes_result = Result.new(:id => "R1", :text => "Yes, go out.")
no_result = Result.new(:id => "R2", :text => "No, don't go out.")
quiz.add_result(yes_result)
quiz.add_result(no_result)
quiz.results #=> [#<Result @id="R1">, #<Result @id="R2">]
```

Next, you'll have to implement a `#find_question` and `#find_result` methods so that given a question ID or a result ID, the Quiz can find the corresponding object. __Hint: Use Ruby's [`#detect`](https://ruby-doc.org/core-2.2.3/Enumerable.html#method-i-detect) method.__

```ruby
quiz = Quiz.new(1, "Should I go out tonight?")

question_1 = Question.new(:id => "Q1", :text => "Are you tired?", :answers => {
    "Yes" => "R2",
    "No" => "Q2"
})
quiz.add_question(question_1)

q1 = quiz.find_question("Q1") #=> #<Question @id="Q1">

yes_result = Result.new(:id => "R1", :text => "Yes, go out.")
quiz.add_result(yes_result)

r1 = quiz.find_result("R1") #=> #<Result @id="R1">
```

Finally, you'll be implementing a `#next_step` method that will take a step_id in the decision tree, either a question to proceed to or a result to return. This `#next_step` method should look at the argument that it receives and if it begins with a `Q`, find and return the question using `#find_question` and if it begins with an `R`, find and return the result. __Hint: Ruby has a [`#start_with?`](https://ruby-doc.org/core-2.1.0/String.html#method-i-start_with-3F) method for strings.__

```ruby
quiz = Quiz.new(1, "Should I go out tonight?")

question_1 = Question.new(:id => "Q1", :text => "Are you tired?", :answers => {
    "Yes" => "R2",
    "No" => "Q2"
})
quiz.add_question(question_1)

yes_result = Result.new(:id => "R1", :text => "Yes, go out.")
quiz.add_result(yes_result)

q1 = quiz.next_step("Q1") #=> #<Question @id="Q1">
r1 = quiz.next_step("R1") #=> #<Result @id="R1">
```

### `data/seed.rb`

Once you have your models all setup, you'll want to build out the data for your quiz before building the controllers and views. Inside of `data/seed.rb` you can see a sample setup of a quiz with questions and results. It uses the model methods you just built to create all the data the application will need.

Define your quizzes, questions, and results in this file so that when your Sinatra application loads, it actually has data. If you get an error when booting up your application, check the backtrace and see if it's originating from `data/seed.rb`.

Don't create the entire quiz, questions, and results, just enough to start being able to build with, you can always add more later!

## Controllers and Views

Once our model layer is complete, the next step is to build out our controller, routes, and views. The application is going to respond to 4 URLs and provide 3 views. You can create all your routes in `ApplicationController` defined in `app/controllers/application_controller.rb`

### GET `/`

The homepage of the application should be provided by a `get` route and render `app/views/index.html.erb`. Within `app/views/index.html.erb`, the only requirement is that you list all the quiz instances that exist providing a link to each quizzes page.

```ruby
# If you had this quiz in data/seed.rb
q1 = Quiz.new(1, "Should I go out tonight?")
q2 = Quiz.new(2, "What should I wear?")
```

The `app/views/index.html.erb` should render links for each quiz with the correct URL and the quizzes' title as the text of the link.

```html
<a href="/quiz/1">Should I go out tonight?</a>
<a href="/quiz/2">What should I wear?</a>
```

### GET `/quiz/:id`

This route will accept a route variable that will be available in `params[:id]` representing the ID of the quiz you wish to begin. Within the route, you should load the quiz by `Quiz.find_by_id` into an instance variable that you can pass to the view, probably `@quiz`.

You also need to load the first question of the quiz, it might be a good idea to do that in the route also and into an instance variable `@question`, maybe through something like `@question = @quiz.questions.first`. The view you will render, `app/views/quiz.html.erb` will expect to use `@quiz` and `@question`.

#### `app/views/quiz.html.erb`

This is the main quiz view, responsible for the form the person will use to submit their answer to a question. The form should include an action pointing to `/quiz/:id` where the `:id` is filled in with the id of the quiz loaded in the route, probably `@quiz`. The method of that form should be `POST`.

For the current question of the quiz, loaded in the route, probably in `@question`, you should put the question's text in the page, maybe use an `<h2>` tag. Then for each answer of the question, accessible via `@question.answers`, you need to generate an `<input>` tag of `type` `radio` with a name of `next_step`, an `id` with the value of the `answer`, and a `value` that is the value of the answer. You should also generate a `<label>` tag with a `for` whose value is the value of the answer and whose inner text is the key of the answer hash. Remember, the answers are in the form of a hash, so given a question:

```ruby
@question = Question.new(:id => "Q1", :text => "Are you tired?", :answers => {
    "Yes" => "R2",
    "No" => "Q2"
})
```

You would expect `@question.answers` to be:

```ruby
{
    "Yes" => "R2",
    "No" => "Q2"
}
```

And you would want to see something like the following HTML in the form:

```html
<p>
  <input type="radio" name="next_step" id="R2" value="R2" />
  <label for="R2">Yes</label>
</p>
<p>
  <input type="radio" name="next_step" id="Q2" value="Q2" />
  <label for="Q2">No</label>
</p>
```

__Hint: Read about iterating over a hash with [`#each`](https://ruby-doc.org/core-2.2.0/Hash.html#method-i-each)__

Finally, make sure the form has an `<input>` or `<button>` of type submit so you can actually submit the answer.

### POST `/quiz/:id`

This is perhaps the most complicated part of the application, building the route that accepts the answer the person gave, loads the next step of the decision tree, and either redirects to a result or loads the next question and renders the `app/views/quiz.html.erb` form with the new question.

Load the quiz instance from the id in `params`. Use the `#next_step` instance method on the quiz, passing in the value from the radio input the person selected, located in `params[:next_step]`. It might look something like:

```ruby
post '/quiz/:id' do
  @quiz = Quiz.find_by_id(params[:id])
  @next_step = @quiz.next_step(params[:next_step])
```

Then, you have to check if the return value from `#next_step` is an instance of `Result` or an instance of `Question`. If it's a `Result`, redirect them to the results page located at `/quiz/:id/results/:result_id`, otherwise, put the question into an instance variable called `@question` (or whatever you named it in the previous route), so that you can re-render the `app/views/quiz.html.erb` view. By using consistent instance variable names, we can re-use views. __Hint: You can check the class of an object via [`#is_a?`](https://ruby-doc.org/core-2.5.0/Object.html#method-i-is_a-3F).__

### GET `/quiz/:id/results/:result_id`

The last part of the application is the route that will show the person the result of the decision tree. In this route, you'll need to find the quiz and load it into an instance variable using the `id` from the URL, and then load the result into an instance variable. You can find the result using the quiz instance method `#find_result`, passing in the `result_id` from `params` in the URL. Render the `app/views/result.html.erb` template and you're all done!

## Debugging

When building your model methods, it might be helpful to insert a `binding.pry` into the methods as you build them.

When building the controller, routes, and views, you can also insert a `binding.pry` in the route, which will pause the application and provide you a console to debug in the terminal. Once you exit the console, the request will continue.

Sinatra can throw some weird errors if your ERB views are broken, especially if you're missing closing or opening `<%` `%>` tags. Try to read the Sinatra backtrace in the log or look at the error Sinatra is throwing in the browser.

__In general, the less code you add before running the tests or hitting refresh in the browser, the easier it will be to debug.__

## Getting Creative

There's lots of room to customize this application from theming it with styles to implementing decisions trees that mean something to you.

### Themes

Use themes from WrapBootstrap.com, Bootstrap.com, and more. The [Bootstrap](https://github.com/learn-co-curriculum/kwk-l1-flowchart-project-template/tree/bootstrap-example) Branch of this project includes HTML and CSS using Bootstrap.

### Decision Tree Ideas

In terms of the decision trees you can build, it can really be anything.

- What college should I go to?
- What should I major in?
- What movie should I watch tonight?
- What should I do if I'm being bullied?

You can provide as many questions and results as you want. You can even build multiple quizzes in the same application.

## Deploying to Heroku

Whenever you're ready, you can deploy this application to [Heroku](https://heroku.com). Make sure you have a heroku account and then try [![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)
