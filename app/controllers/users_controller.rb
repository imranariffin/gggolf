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
    @player_tournaments = @user.player_tournaments
    @admin_tournaments = @user.admin_tournaments
    @sponsor_tournaments = @user.sponsor_tournaments
  end

  def edit
    @user = User.find params[:id]
  end

  def create
    @user = User.create user_params
    redirect_to @user
  end

  def update
    @user = User.update params[:id], user_params

    redirect_to user_path
  end

  def destroy
    @user = User.find(params[:id]).destroy
 
    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:fname, :lname, :email, :phone,:user_image)
    end
end