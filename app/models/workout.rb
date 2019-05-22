class Workout < ApplicationRecord
    belongs_to :user
    has_many :workout_exercises
    has_many :exercises, through: :workout_exercises
    has_many :reviews

    validates :workout_name, presence: true, uniqueness: true
    validates :workout_description, presence: true
    validates :workout_instructions, presence: true
    validate :validate_workout_exercises

    accepts_nested_attributes_for :workout_exercises, reject_if: proc { |attributes| attributes[:sets].blank? && attributes[:repetitions].blank? && attributes[:exercise_attributes][:exercise_name].blank? }

    def validate_workout_exercises
        if workout_exercises.length < 1
          errors.add(:workout_exercises, "must have at least one set, repetition and exercise listed")
        end
    end

    def build_multiple_exercises
        7.times { workout_exercises.build.build_exercise }
    end

end