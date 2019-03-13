class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @pet.update(owner: Owner.find_or_create_by(name: params[:owner][:name]))
    else
      @pet.owner = Owner.find_by(name: params[:owner][:name])
    end
    # binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :"/pets/edit"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    # binding.pry
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    ####### bug fix
    if !params[:pet].keys.include?("owner_id")
      params[:pet]["owner_id"] = []
    end
    #######

    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params[:owner][:name].empty?
      # binding.pry
      @pet.update(owner: Owner.find_or_create_by(name: params[:owner][:name]))
    else
      @pet.owner = Owner.find(params[:pet][:owner_id])
    end
    # binding.pry
    redirect to "pets/#{@pet.id}"
  end
end
