class PausePadraosController < ApplicationController
  # GET /pattern_pauses
  # GET /pattern_pauses.xml
  def index
    @pattern_pauses = PausePadrao.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pattern_pauses }
    end
  end

  # GET /pattern_pauses/1
  # GET /pattern_pauses/1.xml
  def show
    @pattern_pause = PausePadrao.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pattern_pause }
    end
  end

  # GET /pattern_pauses/new
  # GET /pattern_pauses/new.xml
  def new
    @pattern_pause = PausePadrao.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pattern_pause }
    end
  end

  # GET /pattern_pauses/1/edit
  def edit
    @pattern_pause = PausePadrao.find(params[:id])
  end

  # POST /pattern_pauses
  # POST /pattern_pauses.xml
  def create
    @pattern_pause = PausePadrao.new(params[:pattern_pause])

    respond_to do |format|
      if @pattern_pause.save
        flash[:notice] = 'PausePadrao was successfully created.'
        format.html { redirect_to(@pattern_pause) }
        format.xml  { render :xml => @pattern_pause, :status => :created, :location => @pattern_pause }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pattern_pause.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pattern_pauses/1
  # PUT /pattern_pauses/1.xml
  def update
    @pattern_pause = PausePadrao.find(params[:id])

    respond_to do |format|
      if @pattern_pause.update_attributes(params[:pattern_pause])
        flash[:notice] = 'PausePadrao was successfully updated.'
        format.html { redirect_to(@pattern_pause) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pattern_pause.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pattern_pauses/1
  # DELETE /pattern_pauses/1.xml
  def destroy
    @pattern_pause = PausePadrao.find(params[:id])
    @pattern_pause.destroy

    respond_to do |format|
      format.html { redirect_to(pattern_pauses_url) }
      format.xml  { head :ok }
    end
  end
end
