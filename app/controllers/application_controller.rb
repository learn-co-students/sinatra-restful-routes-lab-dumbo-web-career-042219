class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes/new' do
  erb :'recipes/new' 
end

  post '/recipes' do  
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes' do
  	@recipes = Recipe.all
  	erb :'/recipes/index'
  end

  get '/recipes/:id' do
  	@recipe = Recipe.find(params[:id])
  	erb :'/recipes/show'
  end

  delete '/recipes/:id' do
  	@recipe = Recipe.find(params[:id]) 
  	@recipe.destroy 
  	redirect '/recipes'
  end

get '/recipes/:id/edit' do
  @recipe = Recipe.find(params[:id]) 
  erb :'recipes/edit' 
end

put '/recipes/:id' do

  @recipe = Recipe.find(params[:id]) #define variable to edit
  @recipe.assign_attributes(params[:recipe]) #assign new attributes
  if @recipe.save #saves new recipe or returns false if unsuccessful
    redirect '/recipes' #redirect back to recipes index page
  else
    erb :'recipes/edit' #show edit recipe view again(potentially displaying errors)
  end
end

  delete '/recipes/:id' do #destroy action
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to '/recipes'
  end

  patch '/recipes/:id' do  
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

end
