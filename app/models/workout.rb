class Workout < ApplicationRecord
    belongs_to :user
    has_many :workout_exercises
    has_many :exercises, through: :workout_exercises

    validates :workout_name, presence: true, uniqueness: true
    validates :workout_description, presence: true
    validates :workout_instructions, presence: true

    accepts_nested_attributes_for :workout_exercises, reject_if: proc { |attributes| attributes['sets'].blank? && attributes['repetitions'].blank? && attributes['exercise_attributes']['exercise_name'].blank? }

    def build_multiple_exercises
        7.times { workout_exercises.build.build_exercise }
    end

end