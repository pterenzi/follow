class UserSessionsController < ApplicationController
    
    layout 'login'
    
     before_filter :require_no_user, :only => [:new, :create]
     before_filter :require_user, :only => :destroy

     def new
       flash[:notice] = nil
       @user_session = UserSession.new
       @my_tasks = Hash.new
     end

     def create
       @user_session = UserSession.new(params[:user_session])
       if @user_session.save
         #debugger
         #if current_user
           user = User.find_by_login(@user_session.login)
           I18n.locale = user.preferred_language
         #end
         redirect_to tasks_path
       else
         render :action => :new
       end
     end

     def destroy
       current_user_session.destroy
       session[:client_id] = nil
       #flash[:notice] = "Logout successful!"
       redirect_to tasks_path
     end
end
