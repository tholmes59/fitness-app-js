class ExerciseSerializer < ActiveModel::Serializer
  attributes :id, :exercise_name, :created_at, :updated_at

  has_many :workout_exercises, serializer: WorkoutExerciseSerializer
  has_many :workouts, through: :workout_exercises

end
