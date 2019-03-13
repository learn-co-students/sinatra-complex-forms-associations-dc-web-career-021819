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
    if !params[:owner][:name].empty?
      #binding.pry
      @owner = Owner.create(name: params[:owner][:name])
      @pet.update(owner_id: @owner.id)
    else
      @owner = Owner.find(params[:pet][:owner_id])
      @pet.update(owner_id: @owner.id)
    end
    redirect to "pets/#{@pet.id}"
  end

  get "/pets/:id/edit" do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owner = Owner.find(@pet.owner_id)
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    if !params[:owner][:name].empty?
      @owner = Owner.create(name: params[:owner][:name])
      @pet.update(owner_id: @owner.id)
      #@pet.owner_id << Owner.create(name: params[:owner][:name])
    else
      @pet.update(params[:pet])
    end
    redirect to "pets/#{@pet.id}"
  end
end
