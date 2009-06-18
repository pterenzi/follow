class UsersController < ApplicationController

# TODO colocar layout em users
  layout "follow"
#TODO retirar o comment abaixo
  before_filter :require_user
  before_filter :busca_tasks
   
  def index
    @users = User.all(:order=>"login")  
  end
  
  def new
    @user = User.new
    @categories = Categories.all(:order=>"name").collect{|obj| [obj.name,obj.id]}
    @companies = Company.all(:order=>:name).collect{|obj| [obj.name,obj.id]}
  end
  
  def create
    debugger
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Usuário criado !"
      redirect_to tasks_path
    else
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end
 
  def edit
    @user = @current_user
    @categories = Categories.all(:order=>"name").collect{|obj| [obj.name,obj.id]}
    @companies = Company.all(:order=>:name).collect{|obj| [obj.name,obj.id]}
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to tasks_path
    else
      render :action => :edit
    end
  end
end
