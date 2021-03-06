class PostsController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @rateable = @post
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = current_user.posts.find(params[:id])
    if params[:post] && params[:post].has_key?(:user_id)
      params[:post].delete(:user_id)
    end

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  def news
    @posts = Post.where(:category => "News")

    respond_to do |format|
      format.html # news.html.erb
      format.json { render json: @posts }
    end
  end

  def writing
    @posts = Post.where(:category => "Writing")

    respond_to do |format|
      format.html # writing.html.erb
      format.json { render json: @posts }
    end
  end

  def commentary
    @posts = Post.where(:category => "Commentary")

    respond_to do |format|
      format.html # commentary.html.erb
      format.json { render json: @posts }
    end
  end

  def meditations
    @posts = Post.where(:category => "Meditation")

    respond_to do |format|
      format.html # meditations.html.erb
      format.json { render json: @posts }
    end
  end

  def travel
    @posts = Post.where(:category => "Travel")

    respond_to do |format|
      format.html # travel.html.erb
      format.json { render json: @posts }
    end
  end

  def images
    @posts = Post.where(:category => "Image")

    respond_to do |format|
      format.html # images.html.erb
      format.json { render json: @posts }
    end
  end

end
