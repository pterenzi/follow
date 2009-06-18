class MessagesController < ApplicationController
   
  before_filter :authorize
   
   require 'brazilian-rails'
   
   layout "layouts/follow" ,  :except => :show_export

   @page_title = "Messages"
   @controler_name = "message"
   
   # GET /messages GET /messages.xml
   def index
      @messages = Message.find(:all)
      respond_to do |format|
         format.html # index.html.erb
         format.xml  { render :xml => @messages }
      end
   end

   # GET /messages/1 GET /messages/1.xml
   def show
      @message = Message.find(params[:id])
      
      respond_to do |format|
         format.html # show.html.erb
         format.xml  { render :xml => @message }
      end
   end

   # GET /messages/new GET /messages/new.xml
   def new
      @message = Message.new
      respond_to do |format|
         format.html # new.html.erb
         format.xml  { render :xml => @message }
      end
   end

   # GET /messages/1/edit
   def edit
      @message = Message.find(params[:id])
     

   end

   # POST /messages POST /messages.xml
   def create
      
         @message = Message.new(params[:message])
    
         respond_to do |format|
            if @message.save
               flash[:notice] = 'A message foi cadastrada com sucesso!'
               format.html { redirect_to(@message) }
               format.xml  { render :xml => @message, :status => :created, :location => @message }
            else
               format.html { render :action => "new" }
               format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
            end
         end
      end

      # PUT /messages/1 PUT /messages/1.xml
      def update
         @message = Message.find(params[:id])
         respond_to do |format|
            if @message.update_attributes(params[:message])
               flash[:notice] = 'A message foi alterada com sucesso!'
               format.html { redirect_to(@message) }

               format.xml  { head :ok }
            else
               format.html { render :action => "edit" }
               format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
            end
         end
      end

      # DELETE /messages/1 DELETE /messages/1.xml
      def destroy
         @message = Message.find(params[:id])
         name = @message.name
         if @message.destroy
            flash[:notice] = 'O message ' + name + ' foi excluido com sucesso!'
         end

         respond_to do |format|
            format.html { redirect_to(messages_url) }
            format.xml  { head :ok }
         end
      end
   
   
      def show_export
         headers['Content-Type'] = "application/vnd.ms-excel"
         headers['Content-Disposition'] = 'attachment; filename="excel-export.xls"'
         headers['Cache-Control'] = ''
         @messages = Message.find(:all )
         @titulo = "Messages"
         render :layout => "excel"
      end
  

   
   end
