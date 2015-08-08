class UsersController < ApplicationController
  before_action :signed_in,    only: [:edit, :update, :destroy] #ログインしないと編集できない
  before_action :admin_user,   only: [:edit, :update, :destroy] #自分だけが編集できる

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if @current_user.update(user_params)
      flash[:success] = "Profile changed"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @following_users = @user.following_users
  end
  
  # def followers
    
  # end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :profile, :region, :password, :password_confirmation)
  end
  
  def signed_in
      redirect_to login_path, notice: "Please sign in." unless logged_in?
  end
  
  def admin_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
  end
  
end