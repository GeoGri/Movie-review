class Genre < ActiveRecord::Base
    has_many :genres_movies, inverse_of: :genre
    has_many :movies, :through => :genres_movies
    
    accepts_nested_attributes_for :genres_movies,
           :reject_if => :all_blank,
           :allow_destroy => true
    accepts_nested_attributes_for :movies
end
