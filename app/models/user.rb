class User < ApplicationRecord
    has_many :workouts
    has_many :reviews

    has_secure_password
    validates :username, :email, presence: true
    validates :username, :email, uniqueness: true

end
