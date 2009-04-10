class TarefasController < ApplicationController

  before_filter :authorize

  layout 'follow'

  # GET /tarefas GET /tarefas.xml
  def index
    @tarefas = Tarefa.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tarefas }
    end
  end

  # GET /tarefas/1 GET /tarefas/1.xml
  def show
    @tarefa = Tarefa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tarefa }
    end
  end

  # GET /tarefas/new GET /tarefas/new.xml
  def new
    @tarefa = Tarefa.new

    @projetos = Projeto.find(:all).collect{|obj| [obj.id,obj.id]}
    @usuarios = Usuario.find(:all).collect{|obj| [obj.id,obj.id]}
    @situacaos = Situacao.find(:all).collect{|obj| [obj.id,obj.id]}


    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tarefa }
    end
  end

  # GET /tarefas/1/edit
  def edit
    @tarefa = Tarefa.find(params[:id])

    @projetos = Projeto.find(:all).collect{|obj| [obj.id,obj.id]}
    @usuarios = Usuario.find(:all).collect{|obj| [obj.id,obj.id]}
    @situacaos = Situacao.find(:all).collect{|obj| [obj.id,obj.id]}


  end

  # POST /tarefas POST /tarefas.xml
  def create
    @tarefa = Tarefa.new(params[:tarefa])

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
end
