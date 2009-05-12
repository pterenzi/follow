class PausaPadraosController < ApplicationController
  # GET /pausa_padraos
  # GET /pausa_padraos.xml
  def index
    @pausa_padraos = PausaPadrao.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pausa_padraos }
    end
  end

  # GET /pausa_padraos/1
  # GET /pausa_padraos/1.xml
  def show
    @pausa_padrao = PausaPadrao.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pausa_padrao }
    end
  end

  # GET /pausa_padraos/new
  # GET /pausa_padraos/new.xml
  def new
    @pausa_padrao = PausaPadrao.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pausa_padrao }
    end
  end

  # GET /pausa_padraos/1/edit
  def edit
    @pausa_padrao = PausaPadrao.find(params[:id])
  end

  # POST /pausa_padraos
  # POST /pausa_padraos.xml
  def create
    @pausa_padrao = PausaPadrao.new(params[:pausa_padrao])

    respond_to do |format|
      if @pausa_padrao.save
        flash[:notice] = 'PausaPadrao was successfully created.'
        format.html { redirect_to(@pausa_padrao) }
        format.xml  { render :xml => @pausa_padrao, :status => :created, :location => @pausa_padrao }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pausa_padrao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pausa_padraos/1
  # PUT /pausa_padraos/1.xml
  def update
    @pausa_padrao = PausaPadrao.find(params[:id])

    respond_to do |format|
      if @pausa_padrao.update_attributes(params[:pausa_padrao])
        flash[:notice] = 'PausaPadrao was successfully updated.'
        format.html { redirect_to(@pausa_padrao) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pausa_padrao.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pausa_padraos/1
  # DELETE /pausa_padraos/1.xml
  def destroy
    @pausa_padrao = PausaPadrao.find(params[:id])
    @pausa_padrao.destroy

    respond_to do |format|
      format.html { redirect_to(pausa_padraos_url) }
      format.xml  { head :ok }
    end
  end
end
