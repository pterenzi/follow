class EmpresasController < ApplicationController
   
   before_filter :authorize
   
   require 'brazilian-rails'
   
   layout "layouts/follow" ,  :except => [:show_export]
   
   @page_title = "Empresas"
   @controler_name = "empresa"
   
   # GET /empresas GET /empresas.xml
   def index
      @empresas = Empresa.find(:all)
     

      respond_to do |format|
         format.html # index.html.erb
         format.xml  { render :xml => @empresas }
      end
      
   end

   # GET /empresas/1 GET /empresas/1.xml
   def show
      @empresa = Empresa.find(params[:id])
      
      respond_to do |format|
         format.html # show.html.erb
         format.xml  { render :xml => @empresa }
      end
   end

   # GET /empresas/new GET /empresas/new.xml
   def new
      @empresa = Empresa.new
      @tipos =  %w(Cliente Fornecedor)
      
      render :layout => 'layouts/follow_ext'# new.html.erb
     
      
   end

   # GET /empresas/1/edit
   def edit
      @empresa = Empresa.find(params[:id])
     

   end

   # POST /empresas POST /empresas.xml
   def create
      
      @empresa = Empresa.new(params[:empresa])
    
      respond_to do |format|
         if @empresa.save
            flash[:notice] = 'A empresa foi cadastrada com sucesso!'
            format.html { redirect_to(@empresa) }
            format.xml  { render :xml => @empresa, :status => :created, :location => @empresa }
         else
            format.html { render :action => "new" }
            format.xml  { render :xml => @empresa.errors, :status => :unprocessable_entity }
         end
      end
   end

   # PUT /empresas/1 PUT /empresas/1.xml
   def update
      @empresa = Empresa.find(params[:id])
      respond_to do |format|
         if @empresa.update_attributes(params[:empresa])
            flash[:notice] = 'A empresa foi alterada com sucesso!'
            format.html { redirect_to(@empresa) }

            format.xml  { head :ok }
         else
            format.html { render :action => "edit" }
            format.xml  { render :xml => @empresa.errors, :status => :unprocessable_entity }
         end
      end
   end

   # DELETE /empresas/1 DELETE /empresas/1.xml
   def destroy
      @empresa = Empresa.find(params[:id])
      name = @empresa.nome
      if @empresa.destroy
         flash[:notice] = 'O empresa ' + name + ' foi excluido com sucesso!'
      end

      respond_to do |format|
         format.html { redirect_to(empresas_url) }
         format.xml  { head :ok }
      end
   end
   
   
   def show_export
      headers['Content-Type'] = "application/vnd.ms-excel"
      headers['Content-Disposition'] = 'attachment; filename="excel-export.xls"'
      headers['Cache-Control'] = ''
      @empresas = Empresa.find(:all )
      @titulo = "Empresas"
      render :layout => "excel"
   end
  

   
end
