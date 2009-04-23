class AndamentosController < ApplicationController
  # GET /andamentos
  # GET /andamentos.xml
  def index
    @andamentos = Andamento.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @andamentos }
    end
  end

  # GET /andamentos/1
  # GET /andamentos/1.xml
  def show
    @andamento = Andamento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @andamento }
    end
  end

  # GET /andamentos/new
  # GET /andamentos/new.xml
  def new
    @andamento = Andamento.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @andamento }
    end
  end

  # GET /andamentos/1/edit
  def edit
    @andamento = Andamento.find(params[:id])
  end

  # POST /andamentos
  # POST /andamentos.xml
  def create
    @andamento = Andamento.new(params[:andamento])

    respond_to do |format|
      if @andamento.save
        flash[:notice] = 'Andamento was successfully created.'
        format.html { redirect_to(@andamento) }
        format.xml  { render :xml => @andamento, :status => :created, :location => @andamento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @andamento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /andamentos/1
  # PUT /andamentos/1.xml
  def update
    @andamento = Andamento.find(params[:id])

    respond_to do |format|
      if @andamento.update_attributes(params[:andamento])
        flash[:notice] = 'Andamento was successfully updated.'
        format.html { redirect_to(@andamento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @andamento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /andamentos/1
  # DELETE /andamentos/1.xml
  def destroy
    @andamento = Andamento.find(params[:id])
    @andamento.destroy

    respond_to do |format|
      format.html { redirect_to(andamentos_url) }
      format.xml  { head :ok }
    end
  end
end
