class ApplicationController < Sinatra::Base
configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get '/' do
    erb :index
  end
  # Add your post route and action below
post '/' do 
  #the first part we can make up = the second part is already assigned names in index 
  @the_result =params[:user_result]
  
  return erb :results
end
 
end