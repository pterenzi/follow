class UserSessionsController < ApplicationController
    
    layout 'login'
    
     before_filter :require_no_user, :only => [:new, :create]
     before_filter :require_user, :only => :destroy

     def new
       @user_session = UserSession.new
       @my_taskss = Hash.new
     end

     def create
       @user_session = UserSession.new(params[:user_session])
       if @user_session.save
       #  flash[:notice] = "Login successful!"
         redirect_to tasks_path
       else
         render :action => :new
       end
     end

     def destroy
       current_user_session.destroy
       #flash[:notice] = "Logout successful!"
       redirect_to tasks_path
     end
end
