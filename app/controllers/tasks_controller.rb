class TasksController < ApplicationController

  before_filter :require_user
  before_filter :retrieve_tasks , :only=>[:index, :show, :new, :edit, :pauser_pattern,
      :search, :reiniciar_pattern_pausen]

  layout 'follow'

  # GET /tasks GET /tasks.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1 GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])
    @comments = Comment.all(:conditions=>["task_id=?",@task.id])
    @pause = Pause.from_task(@task.id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new GET /tasks/new.xml
  def new
    @task          = Task.new
    @task.start_at = Time.current #.strftime("%d-%m-%Y : %H:%M")  #.strftime("%m/%d/%Y %H:%M")
    @companies     = Company.by_name.from_client(current_user.client_id).collect{|obj| [obj.name,obj.id]}.insert(0,"")
    @projects      = Project.by_name.from_client(current_user.client_id).collect{|obj| [obj.name,obj.id]}.insert(0,"")
    @user_groups   = UserGroup.by_name.from_client(current_user.client_id).collect{|obj| [obj.name,obj.id]}.insert(0,"")

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    @companies = Company.all(:order=>'name').collect{|obj| [obj.name,obj.id]}.insert(0,"")
    @projects = Project.all(:order=>'name').collect{|obj| [obj.name,obj.id]}.insert(0,"")
    @user_groups = UserGroup.all(:order=>'name').collect{|obj| [obj.name,obj.id]}.insert(0,"")
 end

  # POST /tasks POST /tasks.xml
  def create
    @task = Task.new(params[:task])
    @task.requestor_id = current_user.id
    @task.client_id    = current_user.client_id
    @task.project_id   = params[:project_id] unless params[:project_id].blank?
    @task.user_alert   = true
    respond_to do |format|
      if @task.save
        flash[:notice] = t(:task_created)
        format.html { redirect_to(tasks_path) }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        @companies = Company.all(:order=>'name').collect{|obj| [obj.name,obj.id]}.insert(0,"")
        @projects = Project.all(:order=>'name').collect{|obj| [obj.name,obj.id]}.insert(0,"")
        @user_groups = UserGroup.all(:order=>'name').collect{|obj| [obj.name,obj.id]}.insert(0,"")
        
        retrieve_tasks
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1 PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'tasks foi alterado com sucesso!'
        format.html { redirect_to tasks_path }
        format.xml  { head :ok }
      else
        @companies = Company.all(:order=>'name').collect{|obj| [obj.name,obj.id]}.insert(0,"")
        @projects = Project.all(:order=>'name').collect{|obj| [obj.name,obj.id]}.insert(0,"")
        @user_groups = UserGroup.all(:order=>'name').collect{|obj| [obj.name,obj.id]}.insert(0,"")
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def encaminhar
    @task = Task.find(params[:task_id])
    @task.user_id = params[:task][:user_id]
    @evaluation = Evaluation.new
    @evaluation.task_id = @task.id
    @evaluation.user_id = @task.user_id
    Task.transaction do
      if @task.save & @evaluation.save
        redirect_to tasks_path
      else
        flash[:notice] = "Houve um problema no encaminhamento da task. Tente novamente e, se o erro persistir, chame o suporte."
        redirect_to tasks_path
      end 
    end
  end
  
  def pauser
    @task = Task.find(params[:id])
  end
  
  def create_pauser
    @pause               = Pause.new
    @pause.task_id       = params[:task_id]
    @pause.justification = params[:justification]
    @pause.date          = Time.current
    @pause.pattern       = false
    @pause.accepted      = true  #TODO Não passando pela aprovação
    @task = @pause.task
    @task.requestor_alert = true
    @comment             = Comment.new
    @comment.user_id     = current_user.id
    @comment.task_id     = @task.id
    @comment.description = @pause.justification
    Task.transaction do
      if @pause.save & @task.save & @comment.save
        redirect_to tasks_path
      else
        flash[:notice] = "Houve um erro ao gravar a pausa desta tarefa. Se o erro persistir, contate o suporte."
        redirect_to tasks_path
      end
    end
  end

  
  def aprovar_pause
    pause = Pause.find(:all, :conditions=>["task_id=?",id]).last
    pause.accepted = true
    if pause.save
      redirect_to tasks_path
    else
      flash[:notice]= "Houve um erro na aprovação desta pause."    
      redirect_to tasks_path
    end
  end
  
  def aprovar_ou_reprovar_pause
    @task = Task.find(params[:task_id])
    @task.requestor_alert = false
    Task.transaction
      @task.save
    
      @pause = Pause.from_task(params[:task_id])
      if params[:reprovar]
        @pause.accepted = false
      else
        @pause.accepted = true
      end
      @pause.comment_requestor = params[:comment]
      @comment = Comment.new
      @comment.user_id = current_user.id
      @comment.task_id = @task.id
      @comment.description = @pause.comment_requestor
      if @pause.save & @comment.save
        redirect_to tasks_path
      else
        flash[:notice] = "Houve um erro na aprovação desta pause."
        redirect_to tasks_path
      end
  end
  
  def reiniciar_a_task
    @pause = Pause.from_task(params[:task_id])
    @pause.restart = Time.current
    @pause.accepted = true
    if @pause.save
      redirect_to tasks_path
    else
      flash[:notice] = "Houve um erro ao reiniciar esta tarefa"
      redirect_to tasks_path
    end
  end
  
  
  def pauser_pattern
    pattern_pause_id = params[:pattern_pause][:pattern_pause_id]
    for task in @my_tasks
      create_pattern_pause(task.id,pattern_pause_id)
    end
    redirect_to tasks_path
  end
  
  def reiniciar_pattern_pause
    for task in @my_tasks
      puts "task : " + task.id.to_s
      pause = Pause.find(:all, :conditions=>["pattern_pause_id not null and task_id=?",task.id]).last
      if !pause.nil? && (!pause.pattern_pause_id.nil? & pause.restart.nil?)
        pause.restart = Time.current
        pause.save
      end
    end
    redirect_to tasks_path
  end
  
  def create_pattern_pause(task_id, pattern_pause_id)
    pause = Pause.new
    pause.task_id = task_id
    pause.date = Time.current
    pause.pattern_pause_id = pattern_pause_id
    pause.save
    #TODO fazer tratamento de erro
  end
  
  
  def change_alert
    @task = Task.find(params[:id])
    if params[:campo]=="requestor"
      @task.requestor_alert = params[:valor]
    else
      @task.user_alert = params[:valor]
    end
    @task.save
    render :json => "true"
  end
  
  def encerrar_task
    @task = Task.find(params[:id])
    @task.end_at = Time.current
    @task.comment_end_user = params[:comment_end]
    @task.requestor_alert = true
    if @task.save
      redirect_to :back
    else
      flash[:notice] = "Houve um erro ao encerrar esta tarefa"
      redirect_to :back
    end
  end
  
  def avaliar_task
    @task = Task.find(params[:id])
    @task.evaluation = params[:evaluation]
    @task.comment_end_requestor = params[:comment]
    if @task.save  
      redirect_to :back  
    else
      flash[:notice] = "Houve um erro na avaliação desta tarefa. Se o erro presistir, contate o suporte."
      redirect_to :back
    end
  end
  
  def recusar_task
    task = Task.find(params[:task_id])
    task.requestor_alert = true  
    task.refused = true
    evaluation = Evaluation.new
    evaluation.task_id = task.id
    evaluation.user_id = task.user_id
    evaluation.user_comment = params[:justification]
    evaluation.refused = true
    Task.transaction do
      if task.save & evaluation.save
        redirect_to tasks_path
      else
        flash[:notice] = "Houve um erro na recusa desta tarefa."
        redirect_to tasks_path
      end
    end
  end
  
  def reencaminhar_task_refused
    @task = Task.find(params[:task_id])
    @task.refused = false
    @task.requestor_alert = false
    @task.justification_recusa = ""
    if params[:commit]=="ok"
      @task.user_id = params[:task][:user_id]
    else
      @task.user_id = nil
    end
    if @task.save
      redirect_to tasks_path
    else
      flash[:notice] = "Houve um erro ao reencaminhar esta tarefa."
      redirect_to tasks_path
    end
  end

  def verify_new_tasks
    @recent_task = Task.recent_task(current_user.id)
    if @recent_task.present?
      if @recent_task.start_at <= (Time.current - 3.minutes)
        @recent_task = nil
      end
    end
    @tasks_comments = Comment.recent_comments(current_user)
    @recent_messages = Message.recent_messages(current_user)
    #TODO transformar em chamada ajax para atualizar a view
  end
  
  def search
    params[:user]="user" unless !params[:user].nil?
    @date = Date.today
    sql = " 1=1"
    if !params[:content].blank?
      sql = sql + " and description like '%" + params[:content] + "%'"
    end
    if params[:user]=="user"
      sql = sql + " and user_id = " + current_user.id.to_s
    else
      sql = sql + " and requestor_id = " + current_user.id.to_s
    end
    @tasks_list = Task.all(:conditions=>sql, :order=>"start_at DESC")
    #@messages = Message.find(:all, :conditions=>sql)  
  end
  
end
