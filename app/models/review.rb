class Review < ActiveRecord::Base
    # associate movie to user and movie
    belongs_to :user 
    belongs_to :movie
end
