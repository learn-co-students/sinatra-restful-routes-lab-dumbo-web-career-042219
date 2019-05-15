class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  #creating a new recipe
  get '/recipes/new' do
    erb :new #show new receipes view
  end

  get '/recipes/:id' do
    #gets params from url
    @recipe = Recipe.find(params[:id]) #define instance variable for view
    # redirect "/recipes/#{@recipe.id}" #redirect back to specific receipes index page
    erb :show
  end

  post '/recipes' do
    #below works with properly formatted params in HTML form
    @recipe = Recipe.create(params) #create/save new receipe
    redirect "/recipes/#{@recipe.id}" #redirect back to specific receipes index page
  end

  #edit recipe
  get '/recipes/:id/edit' do
  #get params from url
  @recipe = Recipe.find(params[:id]) #define intstance variable for view
  erb :edit #show edit recipe view
  end

  #updating a recipe
  patch  '/recipes/:id' do
    #get params from url
    @recipe = Recipe.find(params[:id]) #define variable to edit
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect "/recipes/#{@recipe.id}" #redirect back to recipes index page
  end

  #deleting a recipe
  delete '/recipes/:id' do
    #get params from url
    @recipe = Recipe.find(params[:id]) #define recipe to delete
    @recipe.destroy #delete recipe
    redirect '/recipes' #redirect back to recipes index page
  end

end
