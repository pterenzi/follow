class ProjectsController < ApplicationController
  
  layout "follow"
  
  before_filter :require_user
  before_filter :retrieve_tasks

  
  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.from_client(current_user.client_id)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new
    #@client = Client.find_by_name(params[:client])
    @project.client_id = @client.id
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project           = Project.new(params[:project])
    @project.client_id = current_user.client_id
    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to(@project) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end

def manage_users
  @project = Project.find(params[:id])
  @included = @project.users
  @users = User.by_name.from_client(current_user.client_id)
  @not_selected =  @users - @project.users
end

def insert_user
  @project = Project.find(params[:id])
  @user = User.find(params[:user_id])
  @project.users << @user
  if @project.save
  #TODO tratar excessão, levando-se em conta que é uma rotina ajax
  render :json => "true"
  else
   render :json=>"false"
  end
end

def remove_user
  @project = Project.find(params[:id])
  @user = User.find(params[:user_id])
  @project.users.delete(@user)
  @project.save
  #TODO tratar excessão, levando-se em conta que é uma rotina ajax
  render :json => "true"
end


end
