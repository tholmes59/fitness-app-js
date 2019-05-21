class WorkoutsController < ApplicationController

    def new
        @workout = Workout.new(user_id: params[:user_id])

    end 

    def create
        @workout = current_user.workouts.build(workout_params)
        if workout.save?
            flash[:message] = "Workout created successfully!"
            redirect_to workout_path(@workout)
        else
            render :new
        end
    end



    private

    def workout_params
        params.require(:workout).permit(
            :workout_name, 
            :workout_description, 
            :workout_instructions, 
            :user_id, 
            workout_exercises_attributes: [
                :id,
                :sets,
                :repetitions,
                exercise_attributes: [
                    :id,
                    :exercise_name
                ]
            ]
        )
    end



end
