class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    helper_method :current_user
    helper_method :logged_in?
    before_action :require_login, except: [:new, :home]

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end 

    def logged_in?
        !!current_user
    end 

    def require_login
        redirect_to root_path unless logged_in?
        flash[:error] = "You must be logged in to access this section"
    end 

end
