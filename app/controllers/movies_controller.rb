class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  # jeśli user nie jest zalogowany i proboje kliknac dodanie filmu bedzie
  # przekierowany na logowanie
  before_action :authenticate_user!, except: [:index, :show]
  before_action :best_4_moves, only: [:index]
  before_action :get_movie_user, only: [:show]
  before_action :get_movies_kind, only: [:show]

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end
  
  # wyszukiwanie, jak nie ma parametrow to wszystkie
  def search
    if params[:search].present?
      @movies = Movie.search(params[:search])
    else
      @movies = Movie.all
    end
  end
  
  def post_jason(param)
    @new_rev = param
    
    render json: @new_rev
  end
  
  def best_4_moves
    @best_movies = Movie.order("rating DESC").limit(4)
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    
    @average_review = @movie.rating
    
    
    # wyswietlanie review napisanych pod ten film
    @reviews = Review.where(movie_id: @movie.id).order("created_at DESC")
    
    # if @reviews.blank?
    #   @average_review = 0
    # else
    #   @average_review = @reviews.average(:rating).round(2)
    #   @movie.rating = @average_review
    # end
  end

  # GET /movies/new
  def new
                # associate new movie with user
    #@movie = Movie.new
    @movie = current_user.movies.build
    #@movie.genres = Genre.all
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
                # associate new movie with user
    #@movie = Movie.new(movie_params)
    @movie = current_user.movies.build(movie_params)
    

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
      @genres = Genre.all.map { |genre| [genre.name, genre.id] }
    end
    
    def get_movie_user
      if @movie.user.blank?
        @user_email = "user is no longer available"
      else
        @user_email = @movie.user.email
      end
    end
    
    def get_movies_kind
      @movies_kind = @movie.genres.map{|g| g.name}.join(",")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    
    # add image to params
    def movie_params
      params.require(:movie).permit(:title, :description, :movie_length, :director, :rating, :scenario, :year, :premiere_date, :image, :trailer_src, :genres_movies, :genres_movies_attributes => [:id, :genre_id, :_destroy, :movie_id, genre_attributes: [:id,:name]] )
    end
end
