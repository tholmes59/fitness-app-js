class ReviewsController < ApplicationController
  skip_before_action :verify_authenticity_token

    def new
        @workout = Workout.find(params[:workout_id])
        @review = Review.new
      end
    
      def create
        @workout = Workout.find(params[:workout_id])
        @review = @workout.reviews.build(review_params)
        @review.user = current_user
        if @review.save
          # flash[:message] = "Sucessfully added review!"
          # redirect_to workout_reviews_path
          render json: @review, status: 201
        else
          # render :new
          render json: @review.errors.full_messages, status: 422
        end
      end
    
      def index
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