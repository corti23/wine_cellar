class BottlesController < ApplicationController
  before_action :logged_in_user, only: [ :show, :create, :edit, :update, :destroy]
  before_action :correct_user,   only: [ :show, :edit, :update, :destroy]
  

  def new
    @bottle = Bottle.new
  end
  
  def show
    
  end
  
  def create
    @bottle = current_user.bottles.build(bottles_params)
    if @bottle.save
      flash[:success] = "Bottle created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
  
  def edit
  end
  
  def update
    if @bottle.update_attributes(user_params)
      flash[:success] = "Bottle updated"
      redirect_to @bottle
    else
      render 'edit'
    end
  end
  
  def destroy
    @bottle.destroy
    flash[:success] = "Bottle deleted"
    redirect_to bottles_url
  end
  
  private
  # Before filters
    
    # Confirms the correct user.
    def correct_user
      @bottle = current_user.bottles.find_by(id: params[:id])
      redirect_to root_url if @bottle.nil?
    end
    
end
