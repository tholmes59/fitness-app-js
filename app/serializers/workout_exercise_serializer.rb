class WorkoutExerciseSerializer < ActiveModel::Serializer
  attributes :id, :workout_id, :exercise_id, :sets, :repetitions, :created_at, :updated_at

  belongs_to :workout 
  belongs_to :exercise, serializer: ExerciseSerializer

  # accepts_nested_attributes_for :exercise

  # def exercise_attributes=(exercise_attributes)
  #   exercise_attributes.values.each do |attribute|
  #     self.exercise = Exercise.find_or_initialize_by(exercise_name: attribute)
  #   end
  # end

  attribute(:exercise_name) {|i| i.object.exercise.exercise_name}
  
end
