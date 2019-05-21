class WorkoutsController < ApplicationController

    def new
        @workout = Workout.new(user_id: params[:user_id])
        @workout.build_multiple_exercises
    end 

    def create
        @workout = current_user.workouts.build(workout_params)
        if @workout.save
            flash[:message] = "Workout created successfully!"
            redirect_to workout_path(@workout)
        else
            render :new
        end
    end

    def index
        @workouts = Workout.all

    end

    def show
        set_workout
    end

    def edit
        set_workout
        @workout.build_multiple_exercises
    end

    def update
        set_workout
        if @workout.update(workout_params)
            flash[:message] = "Workout editied successfully"
            redirect_to workout_path(@workout)
        else
            render :edit
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

    def set_workout
        @workout = Workout.find_by(id: params[:id])
        if !@workout
            redirect_to workouts_path
        end
    end



end
