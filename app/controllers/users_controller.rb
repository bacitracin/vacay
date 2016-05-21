class UsersController < ApplicationController
before_action :authenticate_user!, except: [:index, :show] # decide whether to keep this or not

  def new
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
       flash[:notice] = "User profile successfully updated"
       redirect_to @user
     else
       render :edit 
       flash[:notice] = "Oops something went wrong. Please try again."
     end
  end

  def index # See all members of Vacay
    @users = User.all
  end

  def show  # User profile pages
    @user = User.find(params[:id])
  end 

 private

  def user_params
    params.require(:user).permit(:username, :age, :hometown, :info, :email, :password, :password_confirmation) 
  end

end
