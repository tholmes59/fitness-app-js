class ExerciseSerializer < ActiveModel::Serializer
  attributes :id, :exercise_name, :created_at, :updated_at

  has_many :workout_exercises, serializer: WorkoutExerciseSerializer
  has_many :workouts, through: :workout_exercises

  def workout_exercises
    object.workout_exercises
  end

  # attribute(:sets) {|i| i.object.workout_exercise.sets}

end
