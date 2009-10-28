class UserSessionsController < ApplicationController
    
    layout 'login'
    
     before_filter :require_no_user, :only => [:new, :create]
     before_filter :require_user, :only => :destroy

     def new
       if params[:client]
         @client = Client.find_by_name(params[:client])
       else
         @client = Client.find(session[:client_id]) if session[:client_id]
       end
       if @client.nil?
         flash[:notice] = "Cliente não existe"
         redirect_to select_client_clients_path
       else
         flash[:notice] = nil
         session[:client_id] = @client.id
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
