class UsersController < ApplicationController  
  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      flash[:notice] = "have registered"
      redirect_to root_path
    else
      render '/register'
    end
  end

  private
    def users_params
      params.require(:user).permit(:username,:password,:time_zone)
    end
end
