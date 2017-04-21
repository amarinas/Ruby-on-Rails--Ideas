class UsersController < ApplicationController
  before_action :require_login, only:[:show]
  def index
  end

  def show
    @current_user = User.find(session[:user_id])
    @user = User.find(params[:id])
  end

  def edit
  end

  def new
  end
end
