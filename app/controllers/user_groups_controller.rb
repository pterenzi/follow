class UserGroupsController < ApplicationController
  layout "follow"
  before_filter :retrieve_tasks
  # GET /user_groups
  # GET /user_groups.xml
  def index
    @user_groups = UserGroup.from_client(current_user.client_id).active

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_groups }
    end
  end

  # GET /user_groups/1
  # GET /user_groups/1.xml
  def show
    @user_group = UserGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_group }
    end
  end

  # GET /user_groups/new
  # GET /user_groups/new.xml
  def new
    @user_group = UserGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_group }
    end
  end

  # GET /user_groups/1/edit
  def edit
    @user_group = UserGroup.find(params[:id])
  end

  # POST /user_groups
  # POST /user_groups.xml
  def create
    @user_group = UserGroup.new(params[:user_group])
    @user_group.client_id = current_user.client_id
    respond_to do |format|
      if @user_group.save
        flash[:notice] = 'UserGroup was successfully created.'
        format.html { redirect_to(@user_group) }
        format.xml  { render :xml => @user_group, :status => :created, :location => @user_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_groups/1
  # PUT /user_groups/1.xml
  def update
    @user_group = UserGroup.find(params[:id])

    respond_to do |format|
      if @user_group.update_attributes(params[:user_group])
        flash[:notice] = 'UserGroup was successfully updated.'
        format.html { redirect_to(@user_group) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_groups/1
  # DELETE /user_groups/1.xml
  def destroy
    @user_group = UserGroup.find(params[:id])
    @user_group.destroy

    respond_to do |format|
      format.html { redirect_to(user_groups_url) }
      format.xml  { head :ok }
    end
  end
  
  def manage_users
    #TODO colocar no companies and project o client_id
    @companies = Company.by_name.from_client(current_user.client_id).collect{|obj| [obj.name,obj.id]}.insert(0,"")
    @projects = Project.by_name.from_client(current_user.client_id).collect{|obj| [obj.name,obj.id]}.insert(0,"")
    @user_group = UserGroup.find(params[:id])
    @included = @user_group.users
    @users = User.by_name.from_client(current_user.client_id)
    @not_selected =  @users - @user_group.users
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
    @user_group = UserGroup.find(params[:user_group_id])
    @users = User.all(:order=>:name, :conditions=>sql) - @user_group.users
    if !@project.nil?
      @users = @users & @project.users
    end
   
    render :json => @users.collect{|obj| [obj.name,obj.id]}
  end
  
  
  def insert_user
    @user_group = UserGroup.find(params[:id])
    @user = User.find(params[:user_id])
    @user_group.users << @user
    
    if @user_group.save
    #TODO tratar excessão, levando-se em conta que é uma rotina ajax
    render :json => "true"
    else
     render :json=>"false"
    end
  end

  def remove_user
    @user_group = UserGroup.find(params[:id])
    @user = User.find(params[:user_id])
    @user_group.users.delete(@user)
    @user_group.save
    #TODO tratar excessão, levando-se em conta que é uma rotina ajax
    render :json => "true"
  end

end
