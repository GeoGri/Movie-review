class AddMovieGenre < ActiveRecord::Migration
  def up
    Genre.create name: "Horror"
    Genre.create name: "Animation"
    Genre.create name: "Action"
    Genre.create name: "Adventure"
    Genre.create name: "Sci-fi"
    Genre.create name: "Biography"
    Genre.create name: "Drama"
    Genre.create name: "Comedy"
    Genre.create name: "Romance"
    Genre.create name: "Documentary"
    Genre.create name: "Thriller"
    Genre.create name: "Mystery"
  end
end
