class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

   def index
     @posts = Post.order('timestamp DESC').paginate(:page => params[:page], :per_page => 30)
     @posts = @posts.where(bedrooms: params["bedrooms"]) if params["bedrooms"].present?
     @posts = @posts.where(bathrooms: params["bathrooms"]) if params["bathrooms"].present?
     @posts = @posts.where(neighborhood: params["neighborhood"]) if params["neighborhood"].present?
     @posts = @posts.where(neighborhood: params["neighborhood"]) if params["neighborhood"].present?
     @posts = @posts.where("price > ?", params["min_price"]) if params["min_price"].present?
     @posts = @posts.where("price < ?", params["max_price"]) if params["max_price"].present?
     @posts = @posts.where("price > ?", params["min_price"]) if params["min_price"].present?
     @posts = @posts.where("price < ?", params["max_price"]) if params["max_price"].present?
     @posts = @posts.where("sqft > ?", params["min_sqft"]) if params["min_sqft"].present?
     @posts = @posts.where("sqft < ?", params["max_sqft"]) if params["max_sqft"].present?
     @posts = @posts.where(cats: params["cats"]) if params["cats"].present?
     @posts = @posts.where(dogs: params["dogs"]) if params["dogs"].present?
     @posts = @posts.where(w_d_in_unit: params["w_d_in_unit"]) if params["w_d_in_unit"].present?
     @posts = @posts.where(street_parking: params["street_parking"]) if params["street_parking"].present? 
  end

  def home
  end
  
  def show
    @images = @post.images
  end


  def new
    @post = Post.new
  end


  def edit
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end


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

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:heading, :body, :price, :neighborhood, :external_url, :timestamp)
    end
end
