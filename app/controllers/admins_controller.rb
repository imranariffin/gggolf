class AdminsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :is_tournament_admin!

  def index
    @tournament = Tournament.find(params[:tournament_id])
    @admins = @tournament.admins.includes(:user)
  end

  def new
    @user = current_user
    @tournament = Tournament.find params[:tournament_id]
  end

	def create
    @user = current_user
    @tournament = Tournament.find params[:tournament_id]
    @email = params[:email]

    user = User.find_by email: @email
    if user.present? && @tournament.admins.find_by(user_id: user.id).present?
      flash.now[:error] = "User with #{@email} already is an admin."
      render 'new'
    elsif user.present?
      @tournament.admins.create user: user
      redirect_to tournament_admins_path
    else
      flash.now[:error] = "No user with email #{params[:email]} exists, please try again."
      render 'new'
    end
  end

  def destroy
    Admin.find(params[:id]).destroy
    flash[:notice] = 'Admin removed from tournament'
    redirect_to tournament_admins_path
  end

  private

  def is_tournament_admin!
    tournament = Tournament.find params['tournament_id'].to_i
    unless tournament.has_admin? current_user.id
      flash[:error] = 'Only tournament admins can manage admin users.'
      redirect_to tournament
    end
  end
end