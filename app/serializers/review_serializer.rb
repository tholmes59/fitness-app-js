class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :content, :rating, :workout_id, :user_id, :created_at

  belongs_to :user
  belongs_to :workout

  attribute(:reviewer) {|i| i.object.user.username }
end
