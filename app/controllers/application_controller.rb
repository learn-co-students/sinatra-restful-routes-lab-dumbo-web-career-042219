class ApplicationController < Sinatra::Base
  	configure do
    	set :public_folder, 'public'
    	set :views, 'app/views'
  	end

  	#index
  	get '/recipes' do
  		@recipes = Recipe.all
  		erb :'recipes/index'
  	end

  	#new
  	get '/recipes/new' do
  		erb :'recipes/new'
	end
 
	post '/recipes' do
		@recipe = Recipe.create(params)
	  	redirect to "/recipes/#{@recipe.id}"
	end

	#show
	get '/recipes/:id' do
		@recipe = Recipe.find(params[:id])
	  	erb :'recipes/show'
	end

	#edit
	get '/recipes/:id/edit' do
    	@recipe = Recipe.find(params[:id])
    	erb :'recipes/edit'
	end
 
	patch '/recipes/:id' do
		@recipe = Recipe.find(params[:id])
		# @recipe.update(params)
		@recipe.name = params[:name]
		@recipe.ingredients = params[:ingredients]
		@recipe.cook_time = params[:cook_time]
		@recipe.save
		redirect to "/recipes/#{@recipe.id}"
	end

	#delete
	delete '/recipes/:id' do
  		@recipe = Recipe.find(params[:id])
 		@recipe.delete
  		redirect to '/recipes'
	end
end
