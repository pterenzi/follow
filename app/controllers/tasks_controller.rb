class TasksController < ApplicationController

 # before_filter :authorize
  before_filter :require_user
  before_filter :busca_tasks , :only=>[:index, :show, :new, :edit, :pausar_padrao, :reiniciar_padrao]

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
    @comentarios = Comentario.all(:conditions=>["task_id=?",@task.id])
    @situacaos = Situacao.find(:all).collect{|obj| [obj.descricao,obj.id]}
    @pausa = Pausa.da_task(@task.id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new GET /tasks/new.xml
  def new
    @task = Task.new
    @projetos = Projeto.all(:order=>'descricao').collect{|obj| [obj.descricao,obj.id]}

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    @projetos = Projeto.all(:order=>'descricao').collect{|obj| [obj.descricao,obj.id]}
    @situacaos = Situacao.find(:all).collect{|obj| [obj.descricao,obj.id]}
  end

  # POST /tasks POST /tasks.xml
  def create
    debugger
    @task = Task.new(params[:task])
    @task.solicitante_id = current_user.id
    if !@task.user_id.nil?
      Avaliacao.create(:task_id=>@task.id, :user_id=>@task.user_id)
    end
    respond_to do |format|
      if @task.save
        flash[:notice] = 'Task foi cadastrado com sucesso!'
        format.html { redirect_to(tasks_path) }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        busca_tasks
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1 PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])
    debugger
    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'tasks foi alterado com sucesso!'
        format.html { redirect_to(@task) }

        format.xml  { head :ok }
      else

        @projetos = Projeto.find(:all).collect{|obj| [obj.id,obj.id]}
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
    debugger
    @task = Task.find(params[:task_id])
    @task.user_id = params[:task][:user_id]
    @avaliacao = Avaliacao.new
    @avaliacao.task_id = @task.id
    @avaliacao.user_id = @task.user_id
    Task.transaction do
      if @task.save & @avaliacao.save
        redirect_to tasks_path
      else
        flash[:notice] = "Houve um problema no encaminhamento da task. Tente novamente e, se o erro persistir, chame o suporte."
        redirect_to tasks_path
      end 
    end
  end
  
  def pausar
    @task = Task.find(params[:id])
    @situacaos = Situacao.find(:all).collect{|obj| [obj.descricao,obj.id]}
  end
  
  def create_pausar
    @pausa = Pausa.new
    @pausa.task_id = params[:task_id]
    @pausa.justificativa = params[:justificativa]
    @pausa.data = Time.now
    @pausa.padrao=false
    @task = @pausa.task
    @task.alerta_solicitante = true
    Task.transaction do
      if @pausa.save & @task.save
        redirect_to tasks_path
      else
        flash[:notice] = "Houve um erro ao gravar a pauasa desta task. Se o erro persistir, contate o suporte."
        redirect_to tasks_path
      end
    end
  end

  
  def aprovar_pausa
    pausa = Pausa.find(:all, :conditions=>["task_id=?",id]).last
    pausa.aceito = true
    if pausa.save
      redirect_to tasks_path
    else
      flash[:notice]= "Houve um erro na aprovação desta pausa."    
      redirect_to tasks_path
    end
  end
  
  def aprovar_ou_reprovar_pausa
    
    task = Task.find(params[:task_id])
    task.alerta_solicitante = false
    task.save
    
    @pausa = Pausa.da_task(params[:task_id])
    if params[:reprovar]
      @pausa.aceito = false
    else
      @pausa.aceito = true
    end
    @pausa.comentario_solicitante = params[:comentario]
    if @pausa.save
      redirect_to tasks_path
    else
      flash[:notice] = "Houve um erro na aprovação desta pausa."
      redirect_to tasks_path
    end
  end
  
  def reiniciar_a_task
    @pausa = Pausa.da_task(params[:task_id])
    @pausa.reinicio = Time.now
    @pausa.aceito = true
    if @pausa.save
      redirect_to tasks_path
    else
      flash[:notice] = "Houve um erro ao reiniciar esta task"
      redirect_to tasks_path
    end
  end
  
  
  def pausar_padrao
    debugger
    pausa_padrao_id = params[:pausa_padrao][:pausa_padrao_id]
    for task in @minhas_tasks
      create_pausa_padrao(task.id,pausa_padrao_id)
    end
    redirect_to tasks_path
  end
  
  def reiniciar_padrao
    
    for task in @minhas_tasks
      debugger
      puts "task : " + task.id.to_s
      pausa = Pausa.find(:all, :conditions=>["pausa_padrao_id not null and task_id=?",task.id]).last
      debugger
      if !pausa.nil? && (!pausa.pausa_padrao_id.nil? & pausa.reinicio.nil?)
        pausa.reinicio = Time.now
        pausa.save
      end
    end
    redirect_to tasks_path
  end
  
  def create_pausa_padrao(task_id, pausa_padrao_id)
    debugger
    pausa = Pausa.new
    pausa.task_id = task_id
    pausa.data = Time.now
    pausa.pausa_padrao_id = pausa_padrao_id
    pausa.save
    #TODO fazer tratamento de erro
  end
  
  
  def mudar_alerta
    @task = Task.find(params[:id])
    if params[:campo]=="solicitante"
      @task.alerta_solicitante = params[:valor]
    else
      @task.alerta_usuario = params[:valor]
    end
    @task.save
    puts "Mudar alerta da task : " + params[:id]
    render :json => "true"
  end
  
  def encerrar_task
    @task = Task.find(params[:id])
    @task.termino_at = Time.now
    @task.comentario_termino_user = params[:comentario_termino]
    @task.alerta_solicitante = true
    if @task.save
      redirect_to :back
    else
      flash[:notice] = "Houve um erro ao encerrar esta task"
      redirect_to :back
    end
  end
  
  def avaliar_task
    @task = Task.find(params[:id])
    @task.avaliacao = params[:avaliacao]
    @task.comentario_termino_solicitante = params[:comentario_avaliacao]
    if @task.save  
      redirect_to :back  
    else
      flash[:notice] = "Houve um erro na avaliação desta task. SE o erro presistir, contate o suporte."
      redirect_to :back
    end
  end
  
  def recusar_task
    task = Task.find(params[:task_id])
    task.alerta_solicitante = true  
    task.recusada = true
    avaliacao = Avaliacao.new
    avaliacao.task_id = task.id
    avaliacao.user_id = task.user_id
    avaliacao.comentario_recusa_user = params[:justificativa]
    avaliacao.recusada = true
    Task.transaction do
      if task.save & avaliacao.save
        redirect_to tasks_path
      else
        flash[:notice] = "Houve um erro na recusa desta task."
        redirect_to tasks_path
      end
    end
  end
  
  def reencaminhar_task_recusada
    @task = Task.find(params[:task_id])
    @task.recusada = false
    @task.alerta_solicitante = false
    @task.justificativa_recusa = ""
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
  
end
