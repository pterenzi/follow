class RecadosController < ApplicationController
   
  before_filter :authorize
   
   require 'brazilian-rails'
   
   layout "layouts/follow" ,  :except => :show_export

   @page_title = "Recados"
   @controler_name = "recado"
   
   # GET /recados GET /recados.xml
   def index
      @recados = Recado.find(:all)
      respond_to do |format|
         format.html # index.html.erb
         format.xml  { render :xml => @recados }
      end
   end

   # GET /recados/1 GET /recados/1.xml
   def show
      @recado = Recado.find(params[:id])
      
      respond_to do |format|
         format.html # show.html.erb
         format.xml  { render :xml => @recado }
      end
   end

   # GET /recados/new GET /recados/new.xml
   def new
      @recado = Recado.new
      respond_to do |format|
         format.html # new.html.erb
         format.xml  { render :xml => @recado }
      end
   end

   # GET /recados/1/edit
   def edit
      @recado = Recado.find(params[:id])
     

   end

   # POST /recados POST /recados.xml
   def create
      
         @recado = Recado.new(params[:recado])
    
         respond_to do |format|
            if @recado.save
               flash[:notice] = 'A recado foi cadastrada com sucesso!'
               format.html { redirect_to(@recado) }
               format.xml  { render :xml => @recado, :status => :created, :location => @recado }
            else
               format.html { render :action => "new" }
               format.xml  { render :xml => @recado.errors, :status => :unprocessable_entity }
            end
         end
      end

      # PUT /recados/1 PUT /recados/1.xml
      def update
         @recado = Recado.find(params[:id])
         respond_to do |format|
            if @recado.update_attributes(params[:recado])
               flash[:notice] = 'A recado foi alterada com sucesso!'
               format.html { redirect_to(@recado) }

               format.xml  { head :ok }
            else
               format.html { render :action => "edit" }
               format.xml  { render :xml => @recado.errors, :status => :unprocessable_entity }
            end
         end
      end

      # DELETE /recados/1 DELETE /recados/1.xml
      def destroy
         @recado = Recado.find(params[:id])
         name = @recado.nome
         if @recado.destroy
            flash[:notice] = 'O recado ' + name + ' foi excluido com sucesso!'
         end

         respond_to do |format|
            format.html { redirect_to(recados_url) }
            format.xml  { head :ok }
         end
      end
   
   
      def show_export
         headers['Content-Type'] = "application/vnd.ms-excel"
         headers['Content-Disposition'] = 'attachment; filename="excel-export.xls"'
         headers['Cache-Control'] = ''
         @recados = Recado.find(:all )
         @titulo = "Recados"
         render :layout => "excel"
      end
  

   
   end
