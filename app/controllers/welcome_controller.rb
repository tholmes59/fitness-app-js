class WelcomeController < ApplicationController
    def home
      @workouts = Workout.all
    end
  end