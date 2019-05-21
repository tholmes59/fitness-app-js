class WorkoutExercise < ApplicationRecord
    belongs_to :workout 
    belongs_to :exercise 

    validates :sets, presence: true
    validates :exercise, presence: true
    validates :workout, presence: true
    validate :validate_exercise



    def exercise_attributes=(exercise_attributes)
        exercise_attributes.values.each do |attribute|
          self.exercise = Exercise.find_or_initialize_by(exercise_name: attribute)
        end
    end

    def validate_exercise
        if exercise.nil? || exercise.name.blank?
          errors.add(:exercise, "must list one exercise listed")
        end
    end



end