class MessagesController < ApplicationController
   
  layout "follow"
   before_filter :retrieve_tasks

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
      @projects = Project.active.by_name.from_client(current_user.client_id).collect{|obj| [obj.name,obj.id]}.insert(0,"")
      @user_groups = UserGroup.by_name.active.from_client(current_user.client_id).collect{|obj| [obj.name,obj.id]}.insert(0,"")
      @companies = Company.by_name.active.from_client(current_user.client_id).collect{|obj| [obj.name,obj.id]}.insert(0,"")
      @users = User.by_name.from_client(current_user.client_id).collect{|obj| [obj.name,obj.id]}
   end

   # GET /messages/1/edit
   def edit
      @message = Message.find(params[:id])
   end

   # POST /messages POST /messages.xml
   def create
      erro = false
      users = params[:user_id]
      users.each do |user|
        debugger
        @message = Message.new(params[:message])
        @message.user_id = user
        @message.written_by = User.find(current_user.id)
        erro = true unless @message.save
      end
      respond_to do |format|
        if (erro==true)
          flash[:notice] = 'A message foi cadastrada com sucesso!'
          format.html { redirect_to(tasks_path) }
          format.xml  { render :xml => @message, :status => :created, :location => @message }
        else
          @projects = Project.active.by_name.from_client(current_user.client_id).collect{|obj| [obj.name,obj.id]}.insert(0,"")
          @user_groups = UserGroup.active.by_name.from_client(current_user.client_id).collect{|obj| [obj.name,obj.id]}.insert(0,"")
          @companies = Company.active.by_name.from_client(current_user.client_id).collect{|obj| [obj.name,obj.id]}.insert(0,"")
          @users = User.by_name.from_client(current_user.client_id).collect{|obj| [obj.name,obj.id]}.insert(0,"")
          
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
   
   
     def mark_as_readed
        @message = Message.find(params[:id])
        @message.readed = Time.now
        if @message.save
          #TODO o que fazer quando houver um erro
        end
       # redirect_to(tasks_url)
        render :json => "true"
      end
      
      def search
        @date = Date.today
        sql = "user_id = " + current_user.id.to_s 
        if params[:content] && !params[:content].blank?
          sql += " and content like '%" + params[:content] + "%'"
        end
        if params[:user]
          if !params[:user][:id].blank?
            sql += " and written_by = " + params[:user][:id]
            @user = User.find(params[:user][:id])
          end
        end
        if params[:date] 
          sql += " and created_at between '" + first_day(params[:date][:month],params[:date][:year]) + 
                "' and '" + last_day(params[:date][:month],params[:date][:year]) + "'"
          @date = Date.new(params[:date][:year].to_i,params[:date][:month].to_i,1)
        else
          sql += " and created_at between '" + first_day(Date.today.month,Date.today.year) + 
                "' and '" + last_day(Date.today.month,Date.today.year) + "'"
        end
        @messages = Message.find(:all, :include=>[:written_by], :conditions=>sql) 
      end 

  private
  
  def first_day(month,year)
    Date.new(year.to_i,month.to_i,1).to_s
  end
  
  def last_day(month,year)
    d = Date.new(year.to_i,month.to_i,1)
    d = d + 1.month - 1.day
    d.to_s
  end

end
