class UsersController < ApplicationController

  layout "follow"
  before_filter :require_user
  before_filter :retrieve_tasks
   
  def index
    @users = User.all(:order=>"login")  
  end
  
  def new
    @user = User.new
    @categories = Category.all(:order=>"name").collect{|obj| [obj.name,obj.id]}
    @companies = Company.all(:order=>:name).collect{|obj| [obj.name,obj.id]}
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Usuário criado !"
      redirect_to users_path
    else
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end
 #TODO Update users including company
  def edit
    @user = User.find(params[:id])
    @categories = Category.all(:order=>"name").collect{|obj| [obj.name,obj.id]}
    @companies = Company.all(:order=>:name).collect{|obj| [obj.name,obj.id]}
  end
  
  def update
debugger
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "User updated!"
      redirect_to users_path
    else
      render :action => :edit
    end
  end
end
