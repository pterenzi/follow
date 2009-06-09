class ComentariosController < ApplicationController
  # GET /comentarios
  # GET /comentarios.xml
  def index
    @comentarios = Comentario.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comentarios }
    end
  end

  # GET /comentarios/1
  # GET /comentarios/1.xml
  def show
    @usuarios = Usuario.all.collect{|obj| [obj.nome,obj.id]}
    @comentario = Comentario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comentario }
    end
  end

  # GET /comentarios/new
  # GET /comentarios/new.xml
  def new
    debugger
    @task = Task.find(params[:task_id])
    
    @comentario = Comentario.new
    @comentario.task_id = @task.id
    @comentario.usuario_id = session[:usuario_id]
    @usuarios = Usuario.all.collect{|obj| [obj.nome,obj.id]}

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comentario }
    end
  end

  # GET /comentarios/1/edit
  def edit
    @comentario = Comentario.find(params[:id])
    @usuarios = Usuario.all.collect{|obj| [obj.nome,obj.id]}
  end

  # POST /comentarios
  # POST /comentarios.xml
  def create
    @comentario = Comentario.new
    @comentario.user_id = current_user.id
    @task = Task.find(params[:task_id])

    @task.alerta_usuario = (@task.solicitante== current_user)
    @task.alerta_solicitante = (@task.solicitante!= current_user)
    @task.tem_comentario = true

    @comentario.task_id = params[:task_id]
    @comentario.descricao = params[:descricao]
    respond_to do |format|
      Comentario.transaction do
        if @comentario.save & @task.save
       #   flash[:notice] = 'Comentario criado.'
          format.html { redirect_to(tasks_path) }
          format.xml  { render :xml => @comentario, :status => :created, :location => @comentario }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @comentario.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /comentarios/1
  # PUT /comentarios/1.xml
  def update
    @comentario = Comentario.find(params[:id])

    respond_to do |format|
      if @comentario.update_attributes(params[:comentario])
        flash[:notice] = 'Comentario was successfully updated.'
        format.html { redirect_to(task_path(@comentario.task)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comentario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comentarios/1
  # DELETE /comentarios/1.xml
  def destroy
    @comentario = Comentario.find(params[:id])
    @comentario.destroy

    respond_to do |format|
      format.html { redirect_to(comentarios_url) }
      format.xml  { head :ok }
    end
  end
end
