class WorkoutExercise < ApplicationRecord
    belongs_to :workout 
    belongs_to :exercise 

    validates :sets, presence: true
    validates :repetitions, presence: true
    validates :exercise, presence: true
    validates :workout, presence: true

    accepts_nested_attributes_for :exercise


     def exercise_attributes=(exercise_attributes)
        exercise_attributes.values.each do |attribute|
          self.exercise = Exercise.find_or_initialize_by(exercise_name: attribute)
        end
    end

end