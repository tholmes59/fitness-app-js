class WorkoutExerciseSerializer < ActiveModel::Serializer
  attributes :id, :workout_id, :exercise_id, :sets, :repetitions, :created_at, :updated_at

  belongs_to :workout 
  belongs_to :exercise

  attribute(:exercise_name) {|i| i.object.exercise.exercise_name}
  
end
