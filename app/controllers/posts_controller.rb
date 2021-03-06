class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  # http_basic_authenticate_with name: "admin", password: "12345", except: [:index, :show]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.order('created_at DESC')
    
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    unless current_user
        redirect_to new_user_session_path
      else
        render 'form'
    end
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html {
          if params[:post][:picture].present?
            render :crop ## Render the view for cropping
          else
           redirect_to @post, notice: 'Post was successfully created.' 
          end
        }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title,:link, :body, :picture, :picture_crop_x, :picture_crop_y, :picture_crop_w, :picture_crop_h)
    end
end
