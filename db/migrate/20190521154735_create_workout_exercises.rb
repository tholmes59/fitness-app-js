class CreateWorkoutExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :workout_exercises do |t|
      t.integer :workout_id, null: false
      t.integer :exercise_id, null: false
      t.string :sets, null: false
      t.string :repetitions, null: false

      t.timestamps null: false
    end
  end
end
