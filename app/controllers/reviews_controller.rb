class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  # jesli uzytkownik niezalogowany to nie czyta komentarzy
  before_action :authenticate_user!
  #zaczytuje id movie
  before_action :set_movie
  after_action :update_movie_rating, only: [:update, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    # userId review gets current user id
    @review.user_id = current_user.id
    # movieId review gets movi id
    @review.movie_id = @movie.id
    respond_to do |format|
      if @review.save
        update_movie_rating
        format.html { redirect_to @movie, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
        format.js # render review/create.js.erb
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
        format.js # render review/create.js.erb
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @movie, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def post_jason
    create
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end
    
    # find movie 
    def set_movie
      @movie = Movie.find(params[:movie_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:rating, :comment)
    end
    
    def update_movie_rating
      @actual_movies_reviews = Review.where(movie_id: @movie.id).order("created_at DESC")
      @avarage_rating = Review.where(movie_id: @movie.id).average(:rating).round(2)
      @movie.rating = @avarage_rating
      @movie.save
    end
end
