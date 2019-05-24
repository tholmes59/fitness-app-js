class WorkoutsController < ApplicationController
    before_action :check_user, only: [:edit, :update, :destroy]

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
            @workout.build_multiple_exercises
            render :new
        end
    end

    def index
        if params[:user_id]
            @workouts = User.find(params[:user_id]).workouts
        else
            @workouts = Workout.all
        end
    end

    def show
        set_workout
        @review = Review.new
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

    def destroy
        set_workout
        @workout.destroy
        flash[:message] = "This workout was deleted."
        redirect_to workouts_path
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

    def check_user
        set_workout
        if current_user != @workout.user
          flash[:message] = "You cannot edit or delete a workout from another user."
          redirect_to user_path(current_user)
        end
      end



end
