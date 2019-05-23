class SessionsController < ApplicationController
    skip_before_action :require_login, only: [:new, :create, :facebook]

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
          flash[:notice] = "Log In failed, please try again."
          redirect_to login_path
        end
      end
    
      # def facebook
      #   @user = User.find_or_create_by(uid: auth['uid']) do |u|
      #     u.username = auth['info']['name']
      #     u.email = auth['info']['email']
      #     u.password = auth['uid']
      #   end
       
      #   session[:user_id] = @user.id
    
      #   redirect_to user_path(@user)
      # end

      def github
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
          u.username = auth['info']['name']
          u.email = auth['info']['email']
          u.password = auth['uid']
        end
       
        session[:user_id] = @user.id
    
        redirect_to user_path(@user)
      end

      # def github
      #   byebug
      #   @auth = request.env["omniauth.auth"]
      #   if @auth
      #     @user = User.find_or_create_by_omniauth(auth)
      #     session[:user_id] = @user.id
      #     redirect_to user_path(@user)
      #   byebug
      #     else
      #       render :new
          
      #   end
      # end
    
      # def home
        
      # end
    
      def destroy
        session.clear
        redirect_to root_path
      end
    
      private
    
      def auth
        request.env['omniauth.auth']
      end

end