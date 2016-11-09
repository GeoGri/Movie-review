class Movie < ActiveRecord::Base
    searchkick
    # associate movie to user 
    belongs_to :user
    
    # associate review to movie
    has_many :review
    
    has_many :genres_movies, inverse_of: :movie
    has_many :genres, :through => :genres_movies
    
    accepts_nested_attributes_for :genres_movies,
           :reject_if => :all_blank,
           :allow_destroy => true
    accepts_nested_attributes_for :genres
    
    # image 
    has_attached_file :image, styles: { medium: "400x600#"}
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
    validates :title, :description, :movie_length, :director, :image, :presence => true
end
