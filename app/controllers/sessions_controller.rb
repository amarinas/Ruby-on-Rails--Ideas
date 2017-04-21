class SessionsController < ApplicationController
skip_before_action :require_login, only: [ :create, :login ]
  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
        redirect_to "/bright_ideas"
      else
        flash[:errors] =  @user.errors
        redirect_to '/'
      end
  end

  def login
    # render json: params
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/bright_ideas'
    else
      flash[:errors] = ["Invalid Login Credentials"]
      redirect_to '/'
    end
  end

  def logout
    session.delete(:user_id)
    redirect_to '/'
  end
  private
  def user_params
    params.require(:user).permit(:name, :alias, :email, :password, :password_confirmation)
  end
end
