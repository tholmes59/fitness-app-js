class SessionsController < ApplicationController

    def new
        @user = User.new
        render :login
      end
    
      def create
        @user = User.find_by(username: params[:user][:username])
        if @user && @user.authenticate(params[:user][:password])
          session[:user_id] = @user.id
          redirect_to user_path(@user)
        else
          flash[:error] = "Sorry, your username or password was incorrect"
          redirect_to '/login'
        end
      end
    
      def facebook
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
          u.username = auth['info']['name']
          u.email = auth['info']['email']
          u.password = auth['uid']
        end
       
        session[:user_id] = @user.id
    
        redirect_to user_path(@user)
      end
    
      def home
        
      end
    
      def destroy
        session.clear
        redirect_to root_path
      end
    
      private
    
      def auth
        request.env['omniauth.auth']
      end

end