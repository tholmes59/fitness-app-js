class CreateWorkouts < ActiveRecord::Migration[5.2]
  def change
    create_table :workouts do |t|
      t.string :workout_name, null: false
      t.string :workout_description, null: false
      t.string :workout_instructions, null: false
      t.integer :user_id, null: false

      t.timestamps null: false
    end
  end
end
