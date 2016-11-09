class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # associate movie, review to user , depend - usuwa jak zostanie usuniety user
  has_many :movies
  has_many :reviews, dependent: :destroy
end
