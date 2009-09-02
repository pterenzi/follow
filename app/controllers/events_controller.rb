class EventsController < ApplicationController
  
  before_filter :retrieve_tasks
  layout "follow"
  # GET /events
  # GET /events.xml
  def index
    @events = Event.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new
    @event.date = Date.strptime(params[:date])
    @event.user_id = current_user
    @event.written_by = current_user
    render :update do |page|
       page.replace_html "event_form", :partial =>
    "new_event_form", :locals => { :event => @event }
      page["#event_form"].show();
      page["#event_content"].focus();
     end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
     render :update do |page|
       page.replace_html "event_form", :partial =>
    "edit_event_form", :locals => { :event => @event }
       page["#event_form"].show();
       page["#event_content"].focus();
     end
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])
    @event.user_id = current_user.id
    @event.written_by = current_user.id
    respond_to do |format|
      if @event.save
#       @date_calendar = @event.date
#        redirect_to display_calendar_events_path(:date=>@date_calendar)
      #  flash[:notice] = 'Event was successfully created.'
        format.html { redirect_to( tasks_path() ) }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])
#TODO fazer o update event via jquery, retornando rjs
    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash[:notice] = 'Event was successfully updated.'
        format.html { redirect_to(tasks_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_path) }
      format.xml  { head :ok }
    end
  end
  
 # def new_event(data)
#      @event = Event.new
#      @event.date = Date.new(params[:date])
#      render :json => "true"
#  end
  
  def display_calendar
    date = params[:date].split("-")
    @date_calendar = Date.new(date[0].to_i,date[1].to_i,1)
  end

end
