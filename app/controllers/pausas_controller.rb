class PausasController < ApplicationController
  # GET /pausas
  # GET /pausas.xml
  def index
    @pausas = Pausa.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pausas }
    end
  end

  # GET /pausas/1
  # GET /pausas/1.xml
  def show
    @pausa = Pausa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pausa }
    end
  end

  # GET /pausas/new
  # GET /pausas/new.xml
  def new
    @pausa = Pausa.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pausa }
    end
  end

  # GET /pausas/1/edit
  def edit
    @pausa = Pausa.find(params[:id])
  end

  # POST /pausas
  # POST /pausas.xml
  def create
    @pausa = Pausa.new(params[:pausa])

    respond_to do |format|
      if @pausa.save
        flash[:notice] = 'Pausa was successfully created.'
        format.html { redirect_to(@pausa) }
        format.xml  { render :xml => @pausa, :status => :created, :location => @pausa }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pausa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pausas/1
  # PUT /pausas/1.xml
  def update
    @pausa = Pausa.find(params[:id])

    respond_to do |format|
      if @pausa.update_attributes(params[:pausa])
        flash[:notice] = 'Pausa was successfully updated.'
        format.html { redirect_to(@pausa) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pausa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pausas/1
  # DELETE /pausas/1.xml
  def destroy
    @pausa = Pausa.find(params[:id])
    @pausa.destroy

    respond_to do |format|
      format.html { redirect_to(pausas_url) }
      format.xml  { head :ok }
    end
  end
end
