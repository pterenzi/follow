class TasksController < ApplicationController

 # before_filter :authorize
  before_filter :require_user
  before_filter :retrieve_tasks , :only=>[:index, :show, :new, :edit, :pauser_pattern,
      :search, :reiniciar_pattern]

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
    @situacaos = Situacao.find(:all).collect{|obj| [obj.description,obj.id]}
    @pause = Pause.da_task(@task.id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new GET /tasks/new.xml
  def new
    @task = Task.new
    @companies = Company.all(:order=>'name').collect{|obj| [obj.name,obj.id]}.insert(0,"")
    @projetos = Project.all(:order=>'name').collect{|obj| [obj.name,obj.id]}.insert(0,"")
    @user_groups = UserGroup.all(:order=>'name').collect{|obj| [obj.name,obj.id]}.insert(0,"")

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    @projetos = Project.all(:order=>'name').collect{|obj| [obj.description,obj.id]}
    @situacaos = Situacao.find(:all).collect{|obj| [obj.description,obj.id]}
  end

  # POST /tasks POST /tasks.xml
  def create
    debugger
    
    @task = Task.new(params[:task])
    @task.requestor_id = current_user.id
    @task.project_id = params[:project_id] unless params[:project_id].blank?
    @task.user_alert = true
    if !@task.user_id.nil?
      Evaluation.create(:task_id=>@task.id, :user_id=>@task.user_id)
    end
    respond_to do |format|
      if @task.save
        flash[:notice] = 'Task foi cadastrado com sucesso!'
        format.html { redirect_to(tasks_path) }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        @companies = Company.all(:order=>'name').collect{|obj| [obj.name,obj.id]}.insert(0,"")
        @projetos = Project.all(:order=>'name').collect{|obj| [obj.name,obj.id]}.insert(0,"")
        
        retrieve_tasks
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1 PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])
    #debugger
    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'tasks foi alterado com sucesso!'
        format.html { redirect_to(@task) }

        format.xml  { head :ok }
      else

        @projetos = Project.find(:all).collect{|obj| [obj.id,obj.id]}
        @situacaos = Situacao.find(:all).collect{|obj| [obj.id,obj.id]}


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
    @situacaos = Situacao.find(:all).collect{|obj| [obj.description,obj.id]}
  end
  
  def create_pauser
    @pause = Pause.new
    @pause.task_id = params[:task_id]
    @pause.justification = params[:justification]
    @pause.date = Time.now
    @pause.pattern=false
    @task = @pause.task
    @task.requestor_alert = true
    @comment = Comment.new
    @comment.user_id = current_user.id
    @comment.task_id = @task.id
    @comment.description = @pause.justification
    Task.transaction do
      if @pause.save & @task.save & @comment.save
        redirect_to tasks_path
      else
        flash[:notice] = "Houve um erro ao gravar a pausa desta task. Se o erro persistir, contate o suporte."
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
    
      @pause = Pause.da_task(params[:task_id])
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
    @pause = Pause.da_task(params[:task_id])
    @pause.restart = Time.now
    @pause.accepted = true
    if @pause.save
      redirect_to tasks_path
    else
      flash[:notice] = "Houve um erro ao reiniciar esta task"
      redirect_to tasks_path
    end
  end
  
  
  def pauser_pattern
    #debugger
    pattern_pause_id = params[:pattern_pause][:pattern_pause_id]
    for task in @my_tasks
      create_pattern_pause(task.id,pattern_pause_id)
    end
    redirect_to tasks_path
  end
  
  def reiniciar_pattern
    
    for task in @my_tasks
      #debugger
      puts "task : " + task.id.to_s
      pause = Pause.find(:all, :conditions=>["pattern_pause_id not null and task_id=?",task.id]).last
      #debugger
      if !pause.nil? && (!pause.pattern_pause_id.nil? & pause.restart.nil?)
        pause.restart = Time.now
        pause.save
      end
    end
    redirect_to tasks_path
  end
  
  def create_pattern_pause(task_id, pattern_pause_id)
    #debugger
    pause = Pause.new
    pause.task_id = task_id
    pause.date = Time.now
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
    puts "Mudar alerta da task : " + params[:id]
    render :json => "true"
  end
  
  def encerrar_task
    @task = Task.find(params[:id])
    @task.end_at = Time.now
    @task.comment_end_user = params[:comment_end]
    @task.requestor_alert = true
    if @task.save
      redirect_to :back
    else
      flash[:notice] = "Houve um erro ao encerrar esta task"
      redirect_to :back
    end
  end
  
  def avaliar_task
    @task = Task.find(params[:id])
    @task.evaluation = params[:evaluation]
    @task.comment_end_requestor = params[:evaluation_comment]
    if @task.save  
      redirect_to :back  
    else
      flash[:notice] = "Houve um erro na avaliação desta task. SE o erro presistir, contate o suporte."
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
        flash[:notice] = "Houve um erro na recusa desta task."
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
      flash[:notice] = "Houve um erro ao reencaminhar esta task."
      redirect_to tasks_path
    end
  end

  def verify_new_tasks
    @recent_task = Task.recent_task(current_user.id)
    if !@recent_task.nil?
      if @recent_task.created_at <= Time.now - 1.minute
        @recent_task = nil
      end
    end
    @tasks_comments = Comment.recent_comments(current_user)
    @recent_messages = Message.recent_messages(current_user)
  end
  
  def search
    @date = Date.today
    sql = " 1=1"
    @messages = Message.find(:all, :conditions=>sql)  
  end
  
end
