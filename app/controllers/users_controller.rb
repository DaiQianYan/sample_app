class UsersController < ApplicationController
  # Adding a logged_in_user before filter.
  # before_action :logged_in_user, only: [:edit, :update]
  # Requiring a logged-in user for the index action.
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  # A before filter to protect the edit/update pages.
  before_action :correct_user, only: [:edit, :update]
  # A before filter restricting the destroy action to admins.
  before_action :admin_user, only: :destroy 

  def index
    # The user index action.
    # @users = User.all
    # Paginating the users in the index action.
    @users = User.paginate(page: params[:page])
  end 

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

  def edit
    @user = User.find(params[:id])
  end

  # The initial user update action.
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successfull update.
      flash[:success] = "Profile updated"
      redirect_to @user
    else 
      render 'edit'
    end 
  end 

  # Adding a working destory action.
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end 

  private

    def user_params
      params.require(:user).permit(:name, 
                                   :email,
                                   :password,
                                   :password_confirmation)
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      # Adding a logged_in_user before filter.
      unless logged_in?
        # Adding store_location to the logged-in user before fliter.
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end 
    end 

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      # redirect_to(root_url) unless @user == current_user
      redirect_to(root_url) unless current_user?(@user)
    end 

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end 

end
