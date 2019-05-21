class CreateExercises < ActiveRecord::Migration[5.2]
  def change
    create_table :exercises do |t|
      t.string :exercise_name, null: false

      t.timestamps null: false
    end
  end
end
