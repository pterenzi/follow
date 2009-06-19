class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @usuarios = Usuario.all.collect{|obj| [obj.name,obj.id]}
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    debugger
    @task = Task.find(params[:task_id])
    
    @comment = Comment.new
    @comment.task_id = @task.id
    @comment.usuario_id = session[:usuario_id]
    @usuarios = Usuario.all.collect{|obj| [obj.name,obj.id]}

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
    @usuarios = Usuario.all.collect{|obj| [obj.name,obj.id]}
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.new
    @comment.user_id = current_user.id
    @task = Task.find(params[:task_id])

    @task.user_alert = (@task.requestor== current_user)
    @task.requestor_alert = (@task.requestor!= current_user)
    @task.has_comment = true

    @comment.task_id = params[:task_id]
    @comment.description = params[:description]
    respond_to do |format|
      Comment.transaction do
        if @comment.save & @task.save
       #   flash[:notice] = 'Comment criado.'
          format.html { redirect_to(tasks_path) }
          format.xml  { render :xml => @comment, :status => :created, :location => @comment }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(task_path(@comment.task)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end
end
