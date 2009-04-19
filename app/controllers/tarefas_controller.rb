class TarefasController < ApplicationController

  before_filter :authorize
  before_filter :busca_usuario
  before_filter :busca_tarefas, :only=>[:index, :show, :new, :edit]

  layout 'follow'

  # GET /tarefas GET /tarefas.xml
  def index
#    @comentario = Comentario.new
#    @comentario.usuario_id = session[:usuario_id]
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
  
  def alttera_status
    
  end
  
  private
  
  def busca_tarefas
    @tarefas = Tarefa.find(:all)
    @minhas_solicitacoes = Tarefa.all(:order=>"usuario_id", 
         :conditions=>["solicitante_id=? and usuario_id<>solicitante_id",@usuario_logado.id ])
    @minhas_tarefas = Tarefa.all(:order=>'solicitante_id',
         :conditions=>["usuario_id=?",@usuario_logado.id])
    
  end
  
  def busca_usuario
    @usuario_logado = Usuario.find(session[:usuario_id])
  end
end
