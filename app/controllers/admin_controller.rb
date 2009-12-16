class AdminController < ApplicationController

  def login_super_user
    
  end
  
  def validate_super_user
    debugger
    if params[:login]=="admin" and params[:password]=="1423"
      session[:super_user] = params[:login]
      redirect_to clients_path 
    else
      redirect_to :login_super_user 
    end
  end
  
  def logout
    session[:super_user] = nil
    current_user_session.destroy
    redirect_to :login_super_user
  end
end
