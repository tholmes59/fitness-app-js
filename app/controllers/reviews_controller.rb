class ReviewsController < ApplicationController

    def new
        @workout = Workout.find(params[:workout_id])
        @review = Review.new
      end
    
      def create
        @workout = Workout.find(params[:workout_id])
        @review = @workout.reviews.build(review_params)
        @review.user = current_user
        if @review.save
          flash[:message] = "Sucessfully added review!"
          redirect_to workout_reviews_path
        else
          render :new
        end
      end
    
      def index
        # if params[:workout_id]
        #   @reviews = Workout.find(params[:workout_id]).reviews.most_recent
        # else
        #   @reviews = Review.all.most_recent
        # end
        @workout = Workout.find_by_id(params[:workout_id])
            if @workout
               @reviews = @workout.reviews
            else
               redirect_to workouts_path
            end
        end
    
      def show
        @review = Review.find(params[:id])
      end
    
      private
    
      def review_params
        params.require(:review).permit(:content, :rating, :workout_id)
      end

      


end