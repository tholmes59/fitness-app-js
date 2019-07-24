class WorkoutSerializer < ActiveModel::Serializer
  attributes :id, :workout_name, :workout_description, :workout_instructions, :user_id, :created_at

  belongs_to :user
  has_many :workout_exercises
  has_many :exercises, through: :workout_exercises
  has_many :reviews

  def reviews
    object.reviews
  end

end
