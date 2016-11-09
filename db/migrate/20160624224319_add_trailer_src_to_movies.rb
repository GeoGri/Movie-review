class AddTrailerSrcToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :trailer_src, :string
  end
end
