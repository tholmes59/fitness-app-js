class Review < ApplicationRecord
    belongs_to :user
    belongs_to :workout

    validates :rating, :content, presence: true
    validates :rating, numericality: { less_than_or_equal_to: 5, greater_than: 0,  only_integer: true }
    validates :workout_id, presence: true
    validates :user_id, presence: true


    scope :most_recent, -> { order("created_at desc") }

    def self.average_rating
        average(:rating)
    end

end