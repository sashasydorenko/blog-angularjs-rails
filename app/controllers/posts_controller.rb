class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :create, :update, :destroy]
  before_action :is_admin?, only: [:edit, :create, :update, :destroy]

  def index
    @posts = Post.all order: "created_at DESC"
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      head :no_content
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      head :no_content
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.fetch(:post, {}).permit(:title, :desc, :body)
    end

    def is_admin?
      unless current_user && current_user.is_admin? 
        render json: { success: false,
                     errors: { email: 'You are not admin.' } },
                     status: 401
      end
    end
end
