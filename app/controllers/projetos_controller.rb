class ProjetosController < ApplicationController
   
  before_filter :authorize
   
   require 'brazilian-rails'
   
   layout "layouts/follow" ,  :except => :show_export

   @page_title = "Projetos"
   @controler_name = "projeto"
   
   # GET /projetos GET /projetos.xml
   def index
      @projetos = Projeto.find(:all)
      respond_to do |format|
         format.html # index.html.erb
         format.xml  { render :xml => @projetos }
      end
   end

   # GET /projetos/1 GET /projetos/1.xml
   def show
      @projeto = Projeto.find(params[:id])
      
      respond_to do |format|
         format.html # show.html.erb
         format.xml  { render :xml => @projeto }
      end
   end

   # GET /projetos/new GET /projetos/new.xml
   def new
      @projeto = Projeto.new
      respond_to do |format|
         format.html # new.html.erb
         format.xml  { render :xml => @projeto }
      end
   end

   # GET /projetos/1/edit
   def edit
      @projeto = Projeto.find(params[:id])
     

   end

   # POST /projetos POST /projetos.xml
   def create
      
         @projeto = Projeto.new(params[:projeto])
    
         respond_to do |format|
            if @projeto.save
               flash[:notice] = 'A projeto foi cadastrada com sucesso!'
               format.html { redirect_to(@projeto) }
               format.xml  { render :xml => @projeto, :status => :created, :location => @projeto }
            else
               format.html { render :action => "new" }
               format.xml  { render :xml => @projeto.errors, :status => :unprocessable_entity }
            end
         end
      end

      # PUT /projetos/1 PUT /projetos/1.xml
      def update
         @projeto = Projeto.find(params[:id])
         respond_to do |format|
            if @projeto.update_attributes(params[:projeto])
               flash[:notice] = 'A projeto foi alterada com sucesso!'
               format.html { redirect_to(@projeto) }

               format.xml  { head :ok }
            else
               format.html { render :action => "edit" }
               format.xml  { render :xml => @projeto.errors, :status => :unprocessable_entity }
            end
         end
      end

      # DELETE /projetos/1 DELETE /projetos/1.xml
      def destroy
         @projeto = Projeto.find(params[:id])
         name = @projeto.nome
         if @projeto.destroy
            flash[:notice] = 'O projeto ' + name + ' foi excluido com sucesso!'
         end

         respond_to do |format|
            format.html { redirect_to(projetos_url) }
            format.xml  { head :ok }
         end
      end
   
   
      def show_export
         headers['Content-Type'] = "application/vnd.ms-excel"
         headers['Content-Disposition'] = 'attachment; filename="excel-export.xls"'
         headers['Cache-Control'] = ''
         @projetos = Projeto.find(:all )
         @titulo = "Projetos"
         render :layout => "excel"
      end
  

   
   end
