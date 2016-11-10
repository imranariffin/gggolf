class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find params[:id]

    @image_path = "http://www.eecg.toronto.edu/~stumm/stumm.jpg"

    # show tournaments
    @player_tournaments =
    @admins = @user.admins
    @sponsors = @user.sponsors
  end 

  def edit
    @user = User.find params[:id]
  end

  def create
    @user = User.create usr_params
    redirect_to @user
  end

  def update
    @user = User.update params[:id], usr_params

    redirect_to user_path
  end 

  def destroy
    @user = User.find(params[:id]).destroy
 
    redirect_to users_path
  end

  private
    def usr_params
      params.require(:user).permit(:fname, :lname, :dob, :email, :phone)
    end
end