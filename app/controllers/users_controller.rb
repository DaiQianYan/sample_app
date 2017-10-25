class UsersController < ApplicationController

  # 到数据库查找用户并展示
  def show
    @user = User.find(params[:id])
  end

  # 创建新用户
  def new
    @user = User.new
  end

  # 创建用户登陆session？
  def create
    # @user = User.new(params[:user])
    @user = User.new(user_params)
    if @user.save
      log_in @user
      # Handle a successful save.
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, 
                                   :email,
                                   :password,
                                   :password_confirmation)
    end

end
