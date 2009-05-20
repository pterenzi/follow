class TarefasController < ApplicationController

 # before_filter :authorize
  before_filter :require_user
  before_filter :busca_tarefas , :only=>[:index, :show, :new, :edit, :pausar_padrao, :reiniciar_padrao]

  layout 'follow'

  # GET /tarefas GET /tarefas.xml
  def index
    @usuarios = User.all.collect{|obj| [obj.login,obj.id]}
    @situacaos = Situacao.find(:all).collect{|obj| [obj.descricao,obj.id]}
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tarefas }
    end
  end

  # GET /tarefas/1 GET /tarefas/1.xml
  def show
    @tarefa = Tarefa.find(params[:id])
    @comentarios = Comentario.all(:conditions=>["tarefa_id=?",@tarefa.id])
    @situacaos = Situacao.find(:all).collect{|obj| [obj.descricao,obj.id]}
    @usuarios = User.find(:all).collect{|obj| [obj.login,obj.id]}
    @pausa = Pausa.da_tarefa(@tarefa.id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tarefa }
    end
  end

  # GET /tarefas/new GET /tarefas/new.xml
  def new
    @tarefa = Tarefa.new

    @projetos = Projeto.all(:order=>'descricao').collect{|obj| [obj.descricao,obj.id]}
    @usuarios = User.find(:all).collect{|obj| [obj.login,obj.id]}
    @situacaos = Situacao.find(:all).collect{|obj| [obj.descricao,obj.id]}

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tarefa }
    end
  end

  # GET /tarefas/1/edit
  def edit
    @tarefa = Tarefa.find(params[:id])
    @projetos = Projeto.all(:order=>'descricao').collect{|obj| [obj.descricao,obj.id]}
    @usuarios = User.find(:all).collect{|obj| [obj.login,obj.id]}
    @situacaos = Situacao.find(:all).collect{|obj| [obj.descricao,obj.id]}


  end

  # POST /tarefas POST /tarefas.xml
  def create
    @tarefa = Tarefa.new(params[:tarefa])
    @tarefa.solicitante_id = current_user.id
    if @tarefa.user
      @tarefa.situacao_id = 8 # encaminhada
    else
      @tarefa.situacao_id = 1 # aberta
    end
    
    respond_to do |format|
      if @tarefa.save
        flash[:notice] = 'Tarefa foi cadastrado com sucesso!'
        format.html { redirect_to(tarefas_path) }
        format.xml  { render :xml => @tarefa, :status => :created, :location => @tarefa }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tarefa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tarefas/1 PUT /tarefas/1.xml
  def update
    @tarefa = Tarefa.find(params[:id])
    debugger
    respond_to do |format|
      if @tarefa.update_attributes(params[:tarefa])
        flash[:notice] = 'tarefas foi alterado com sucesso!'
        format.html { redirect_to(@tarefa) }

        format.xml  { head :ok }
      else

        @projetos = Projeto.find(:all).collect{|obj| [obj.id,obj.id]}
        @usuarios = User.find(:all).collect{|obj| [obj.id,obj.id]}
        @situacaos = Situacao.find(:all).collect{|obj| [obj.id,obj.id]}


        format.html { render :action => "edit" }
        format.xml  { render :xml => @tarefa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tarefas/1
  # DELETE /tarefas/1.xml
  def destroy
    @tarefa = Tarefa.find(params[:id])
    @tarefa.destroy

    respond_to do |format|
      format.html { redirect_to(tarefas_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def encaminhar
    debugger
    @tarefa = Tarefa.find(params[:tarefa_id])
    @tarefa.user_id = params[:tarefa][:user_id]
   if @tarefa.save
     redirect_to tarefas_path
   else
    #TODO tratar excessão
   end 
     
  end
  
  def pausar
    @tarefa = Tarefa.find(params[:id])
    @usuarios = User.all.collect{|obj| [obj.login,obj.id]}
    @situacaos = Situacao.find(:all).collect{|obj| [obj.descricao,obj.id]}
  end
  
  def create_pausar
    pausa = Pausa.new
    pausa.tarefa_id = params[:tarefa_id]
    pausa.justificativa = params[:justificativa]
    pausa.data = Time.now
    if padrao
      pausa.pausa_padrao_id = pausa_padrao_id
    end
    pausa.padrao=false
    if pausa.save
      redirect_to tarefas_path
    else
      #TODO fazer tratamento de erro
    end
  end
  
  
  def aprovar_pausa
    pausa = Pausa.find(:all, :conditions=>["tarefa_id=?",id]).last
    pausa.aceito = true
    if pausa.save
      redirect_to tarefas_path
    else
      #TODO fazer targtamento de erro    
    end
  end
  
  def aprovar_ou_reprovar_pausa
    @pausa = Pausa.da_tarefa(params[:tarefa_id])
    if params[:reprovar]
      @pausa.aceito = false
    else
      @pausa.aceito = true
    end
    @pausa.comentario_solicitante = params[:comentario]
    if @pausa.save
      redirect_to tarefas_path
    else
      #TODO tratar erro
    end
  end
  
  def reiniciar_a_tarefa
    @pausa = Pausa.da_tarefa(params[:tarefa_id])
    @pausa.reinicio = Time.now
    if @pausa.save
      redirect_to tarefas_path
    else
      #TODO verifica erro
    end
  end
  
  
  def pausar_padrao
    pausa_padrao_id = params[:pausa_padrao][:pausa_padrao_id]
    for tarefa in @minhas_tarefas
      create_pausa_padrao(tarefa.id,pausa_padrao_id)
    end
    redirect_to tarefas_path
  end
  
  def reiniciar_padrao
    
    for tarefa in @minhas_tarefas
      debugger
      puts "tarefa : " + tarefa.id.to_s
      pausa = Pausa.find(:all, :conditions=>["pausa_padrao_id not null and tarefa_id=?",tarefa.id]).last
      debugger
      if !pausa.nil? && (!pausa.pausa_padrao_id.nil? & pausa.reinicio.nil?)
        pausa.reinicio = Time.now
        pausa.save
      end
    end
    redirect_to tarefas_path
  end
  
  def create_pausa_padrao(tarefa_id, pausa_padrao_id)
    debugger
    pausa = Pausa.new
    pausa.tarefa_id = tarefa_id
    pausa.data = Time.now
    pausa.pausa_padrao_id = pausa_padrao_id
    pausa.save
    #TODO fazer tratamento de erro
  end
  
  
  def mudar_alerta
    @tarefa = Tarefa.find(params[:id])
    if params[:campo]=="solicitante"
      @tarefa.alerta_solicitante = params[:valor]
    else
      @tarefa.alerta_usuario = params[:valor]
    end
    @tarefa.save
    puts "Mudar alerta da tarefa : " + params[:id]
    render :json => "true"
  end
  
  def encerrar_tarefa
    @tarefa = Tarefa.find(params[:id])
    @tarefa.termino_at = Time.now
    @tarefa.comentario_termino = params[:comentario_termino]
    @tarefa.alerta_solicitante = true
    @tarefa.save
    #TODO tratar erro
    redirect_to :back
  end
  
  def avaliar_tarefa
    @tarefa = Tarefa.find(params[:id])
    @tarefa.avaliacao = params[:avaliacao]
    @tarefa.comentario_termino_solicitante = params[:comentario_avaliacao]
    @tarefa.save  
    #TODO tratar erro
    redirect_to :back  
  end
  
end
