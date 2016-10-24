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
      redirect_to new_registration_path(:user)
    end
  end

  def update
    super
  end

  private

  def user_params
    p = params.require(:user).permit(:fname, :lname, :dob, :email, :phone, :addr, :password, :password_confirmation)
    p[:dob] = Time.strptime(p[:dob], "%m/%d/%Y")
    p
  end
end 
