class UserSessionsController < ApplicationController
    
    layout 'login'
    
     before_filter :require_no_user, :only => [:new, :create]
     before_filter :require_user, :only => :destroy

     def new
       @client = Client.find_by_name(params[:client])
       if @client.nil?
         flash[:notice] = "Cliente não existe"
       else
         flash[:notice] = nil
         session[:client] = @client.id
         @user_session = UserSession.new
         @my_tasks = Hash.new
       end
     end

     def create
       @user_session = UserSession.new(params[:user_session])
       if @user_session.save
       #  flash[:notice] = "Login successful!"
      # if current_user
#       debugger
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
       #flash[:notice] = "Logout successful!"
       redirect_to tasks_path
     end
end
