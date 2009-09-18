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
    debugger
    params[:password] = '1234'
    params[:confirmation_password] = '1234'
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Usuário criado !"
      redirect_to users_path
    else
      @categories = Category.all(:order=>"name").collect{|obj| [obj.name,obj.id]}
      @companies = Company.all(:order=>:name).collect{|obj| [obj.name,obj.id]}
      
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end

  def edit
    @user = User.find(params[:id])
    @categories = Category.all(:order=>"name").collect{|obj| [obj.name,obj.id]}
    @companies = Company.all(:order=>:name).collect{|obj| [obj.name,obj.id]}
  end
  
  def update
    @user = User.find(params[:id])
    debugger
    if params[:password_confirmation].blank?
      params[:passowrd_confirmation] = params[:password]
    end
    if @user.update_attributes(params[:user])
     # flash[:notice] = "User updated!"
      redirect_to users_path
    else
      @companies = Company.all(:order=>:name).collect{|obj| [obj.name,obj.id]}
      render :action => :edit
    end
  end
  
  def change_password
     @user = User.find(params[:id])
    
  end
end
