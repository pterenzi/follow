class UsersController < ApplicationController

  layout "follow"
  before_filter :require_user
  before_filter :retrieve_tasks
   
  def index
    @users = User.all(:order=>"login", 
           :conditions=>["client_id = ?", current_user.client_id ],
           :include=>[:company, :role])  
  end
  
  def new
    if @client.available_license < 1
          redirect_to users_path
        end
        if current_user.role.level>0
          redirect_to users_path
        end
    @user = User.new
    @categories = Category.all(:order=>"name").collect{|obj| [obj.name,obj.id]}
    @companies = Company.all(:order=>:name).collect{|obj| [obj.name,obj.id]}
  end
  
  def create
    params[:password] = '1234'
    params[:confirmation_password] = '1234'
    @user = User.new(params[:user])
    @user.client_id = @client.id
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
    @companies = Company.all(:order=>:name).collect{|obj| [obj.name,obj.id]}
    @roles = Role.all(:order=>:level).collect{|obj| [obj.name,obj.id]}
  end
  
  def update
    @user = User.find(params[:id])
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
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  def change_password
     @user = User.find(params[:id])
  end

  def retrieve_users
    sql = " 1=1 "
    if !params[:company_id].blank?
      sql << " and company_id = #{params[:company_id]}"
    end
    @project = nil
    if !params[:project_id].blank?
      @project = Project.find(params[:project_id])
    end
    @user_group = nil
    if !params[:user_group_id].blank?
      @user_group = UserGroup.find(params[:user_group_id])
    end
    @users = User.all(:order=>:name, :conditions=>sql)
    if !@project.nil?
      @users = @users & @project.users
    end
    if !@user_group.nil?
      @users = @users & @user_group.users
    end
    render :json => @users.collect{|obj| [obj.name,obj.id]}
  end
end

