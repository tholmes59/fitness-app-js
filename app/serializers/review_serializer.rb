class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :content, :rating, :workout_id, :user_id

  belongs_to :user
  belongs_to :workout
end
