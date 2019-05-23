class User < ApplicationRecord
    has_many :workouts
    has_many :reviews

    has_secure_password
    validates :username, :email, presence: true
    validates :username, :email, uniqueness: true

    # def self.find_or_create_by_omniauth(auth)
    #     where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    #       user.email = auth.info.email
    #       user.password_digest = SecureRandom.hex
    #       user.name = auth.info.name
    #       user.save!
    #     end
    #   end

end
