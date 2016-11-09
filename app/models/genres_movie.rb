class GenresMovie < ActiveRecord::Base
  belongs_to :genre, inverse_of: :genres_movies
  belongs_to :movie, inverse_of: :genres_movies
  
  #accepts_nested_attributes_for :genre,
  #                              :reject_if => :all_blank
end
