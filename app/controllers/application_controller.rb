require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    @recipes = Recipe.find(params[:id])
    erb :show
  end

  post '/recipes' do
    @recipes = Recipe.create(params)
    redirect to "/recipes/#{@recipes.id}"
  end

  get '/recipes/:id/edit' do
    # binding.pry
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipes = Recipe.find(params[:id])
    @recipes.update(params[:recipe])
    redirect to "/recipes/#{@recipes.id}"
  end

  delete '/recipes/:id' do
    @recipes = Recipe.find(params[:id])
    @recipes.destroy
    redirect to '/recipes'
  end



end
