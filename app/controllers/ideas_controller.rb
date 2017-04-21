class IdeasController < ApplicationController
  before_action :require_login

  def index
      @current_user = User.find(session[:user_id])
      @likes = Like.all
      @ideas = Idea.all


  end

  def create
    @users = session[:user_id]
    @post = Idea.create(post_params)

    if @post.valid?
      redirect_to '/bright_ideas'
    else
      flash[:errors] = @post.errors
      redirect_to '/bright_ideas'
    end

  end

  def show
    @user = User.find(session[:user_id])
    @idea = Idea.find(params[:id])

  end

  def destroy
      @idea = Idea.find(params[:id])
      if @idea.user == current_user
        @idea.destroy
        redirect_to '/bright_ideas'
      else
        flash[:errors] = @idea.errors
        redirect_to '/bright_ideas'

      end
  end

  private
  def post_params
    params.require(:post).permit(:idea).merge(user: current_user)
  end
end
