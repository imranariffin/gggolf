class UserRegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_up(:user, @user)
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    super
  end

  private

  def user_params
    params.require(:user).permit(:fname, :lname, :email, :phone, :addr, :password, :password_confirmation)
  end
end 
