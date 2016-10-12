class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def new
    @user = User.new()
  end
  def show
    @user = User.find(params[:id])
  end 
  def edit
    @user = User.find(params[:id])
  end
  def create
    @user = User.new(usr_params)
    @user.save
    redirect_to @user
  end
  def update
    @user = User.find(params[:id])  
    @user.update(usr_params)

    redirect_to user_path
  end 
  def destroy
    @user = User.find(params[:id])
    @user.destroy
 
    redirect_to users_path
  end
  private
    def usr_params
      params.require(:user).permit(:fname, :lname, :dob, :email, :phone)
    end
end