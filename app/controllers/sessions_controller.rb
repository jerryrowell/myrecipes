class SessionsController < ApplicationController
  def new
    
  end
  
  def create
    chef = Chef.find_by(email: params[:session][:email].downcase)
    if chef && chef.authenticate(params[:session][:password])
      session[:chef_id] = chef.id
      cookies.signed[:chef_id] = chef.id
      flash[:success] = "You have successfuly loged in"
      redirect_to chef
    else
      flash.now[:danger] = "There was something worng with your login information"
      render 'new'
    end
  end
  
  def destroy
    session[:chef_id] = nil
    flash[:success] = "You have successfuly loged out"
    redirect_to root_path
  end
  
  
end