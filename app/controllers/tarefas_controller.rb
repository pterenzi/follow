class TarefasController < ApplicationController

  before_filter :authorize
  before_filter :busca_usuario
  before_filter :busca_tarefas , :only=>[:index, :show, :new, :edit, :pausar]

  layout 'follow'

  # GET /tarefas GET /tarefas.xml
  def index
    @usuarios = Usuario.all.collect{|obj| [obj.nome,obj.id]}
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
    @usuarios = Usuario.find(:all).collect{|obj| [obj.nome,obj.id]}
    if @tarefa.pausa_nao_aceita
      @pausa = Pausa.da_tarefa(@tarefa.id)
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tarefa }
    end
  end

  # GET /tarefas/new GET /tarefas/new.xml
  def new
    @tarefa = Tarefa.new

    @projetos = Projeto.all(:order=>'descricao').collect{|obj| [obj.descricao,obj.id]}
    @usuarios = Usuario.find(:all).collect{|obj| [obj.nome,obj.id]}
    @situacaos = Situacao.find(:all).collect{|obj| [obj.descricao,obj.id]}

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tarefa }
    end
  end

  # GET /tarefas/1/edit
  def edit
    @tarefa = Tarefa.find(params[:id])
#debugger
    @projetos = Projeto.all(:order=>'descricao').collect{|obj| [obj.descricao,obj.id]}
    #FIXME combo de usuario não está funcionando. Sempre motra o primeiro
    @usuarios = Usuario.find(:all).collect{|obj| [obj.nome,obj.id]}
    @situacaos = Situacao.find(:all).collect{|obj| [obj.descricao,obj.id]}


  end

  # POST /tarefas POST /tarefas.xml
  def create
    @tarefa = Tarefa.new(params[:tarefa])
    @tarefa.solicitante_id = session[:usuario_id]
    if @tarefa.usuario
      @tarefa.situacao_id = 8 # encaminhada
    else
      @tarefa.situacao_id = 1 # aberta
    end
    
    respond_to do |format|
      if @tarefa.save
        flash[:notice] = 'Tarefa foi cadastrado com sucesso!'
        format.html { redirect_to(@tarefa) }
        format.xml  { render :xml => @tarefa, :status => :created, :location => @tarefa }
      else

        @projetos = Projeto.find(:all).collect{|obj| [obj.id,obj.id]}
        @usuarios = Usuario.find(:all).collect{|obj| [obj.id,obj.id]}
        @situacaos = Situacao.find(:all).collect{|obj| [obj.id,obj.id]}


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
        @usuarios = Usuario.find(:all).collect{|obj| [obj.id,obj.id]}
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
    @tarefa = Tarefa.find(params[:tarefa_id])
    if params[:excluir_tarefa]
      @tarefa.destroy
      respond_to do |format|  
        format.html { redirect_to(tarefas_path) }
      end
    else
      if params[:andamento_id] =='Pausar'
        redirect_to :controller=>'tarefas', :action=>'pausar', :id=>@tarefa.id
        #redirect_to new_andamentos_path 
        #usuario = Usuario.find(params[:usuario_id])
        #@tarefa.usuario_id = usuario.id
        #if tarefa.save
        #  redirect_to tarefas_path
        #end
      end    
    end
  end
  
  def pausar
    @tarefa = Tarefa.find(params[:id])
    @usuarios = Usuario.all.collect{|obj| [obj.nome,obj.id]}
    @situacaos = Situacao.find(:all).collect{|obj| [obj.descricao,obj.id]}
  end
  
  def create_pausar
    debugger
    pausa = Pausa.new
    pausa.tarefa_id = params[:tarefa_id]
    pausa.justificativa = params[:justificativa]
    pausa.data = Time.now
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
    debugger
    #@tarefa = Tarefa.find(params[:tarefa_id])
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
  
  private
  
  def busca_tarefas
    @tarefas = Tarefa.find(:all)
    @minhas_solicitacoes = Tarefa.all(:order=>"usuario_id", 
          :conditions=>["solicitante_id=? and usuario_id<>solicitante_id and usuario_id<>''",@usuario_logado.id ])
    @minhas_tarefas = Tarefa.all(:order=>"solicitante_id", :conditions=>["usuario_id=?  ",@usuario_logado.id])
    @tarefas_sem_usuario = Tarefa.all(:conditions=>["solicitante_id=? and usuario_id='' ",@usuario_logado.id])
    @andamentos = Andamento.all(:conditions=> ["ativo=?",true]).collect{|obj| [obj.nome,obj.nome]}
  end
  
  def busca_usuario
    @usuario_logado = Usuario.find(session[:usuario_id])
  end
end
