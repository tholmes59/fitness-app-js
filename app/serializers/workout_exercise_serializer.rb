class WorkoutExerciseSerializer < ActiveModel::Serializer
  attributes :id, :workout_id, :exercise_id, :sets, :repetitions

  belongs_to :workout 
  belongs_to :exercise
   
end
