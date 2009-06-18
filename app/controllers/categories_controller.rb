class CategoriesController < ApplicationController
   
    before_filter :authorize
   
   require 'brazilian-rails'
   
   layout "layouts/follow" ,  :except => :show_export

   @page_title = "Categories"
   @controler_name = "categories"
   
   # GET /categories GET /categories.xml
   def index
      @categories = Categories.find(:all)
      respond_to do |format|
         format.html # index.html.erb
         format.xml  { render :xml => @categories }
      end
   end

   # GET /categories/1 GET /categories/1.xml
   def show
      @categories = Categories.find(params[:id])
      
      respond_to do |format|
         format.html # show.html.erb
         format.xml  { render :xml => @categories }
      end
   end

   # GET /categories/new GET /categories/new.xml
   def new
      @categories = Categories.new
      respond_to do |format|
         format.html # new.html.erb
         format.xml  { render :xml => @categories }
      end
   end

   # GET /categories/1/edit
   def edit
      @categories = Categories.find(params[:id])
     

   end

   # POST /categories POST /categories.xml
   def create
      
         @categories = Categories.new(params[:categories])
    
         respond_to do |format|
            if @categories.save
               flash[:notice] = 'A categories foi cadastrada com sucesso!'
               format.html { redirect_to(@categories) }
               format.xml  { render :xml => @categories, :status => :created, :location => @categories }
            else
               format.html { render :action => "new" }
               format.xml  { render :xml => @categories.errors, :status => :unprocessable_entity }
            end
         end
      end

      # PUT /categories/1 PUT /categories/1.xml
      def update
         @categories = Categories.find(params[:id])
         respond_to do |format|
            if @categories.update_attributes(params[:categories])
               flash[:notice] = 'A categories foi alterada com sucesso!'
               format.html { redirect_to(@categories) }

               format.xml  { head :ok }
            else
               format.html { render :action => "edit" }
               format.xml  { render :xml => @categories.errors, :status => :unprocessable_entity }
            end
         end
      end

      # DELETE /categories/1 DELETE /categories/1.xml
      def destroy
         @categories = Categories.find(params[:id])
         name = @categories.name
         if @categories.destroy
            flash[:notice] = 'O categories ' + name + ' foi excluido com sucesso!'
         end

         respond_to do |format|
            format.html { redirect_to(categories_url) }
            format.xml  { head :ok }
         end
      end
   
   
      def show_export
         headers['Content-Type'] = "application/vnd.ms-excel"
         headers['Content-Disposition'] = 'attachment; filename="excel-export.xls"'
         headers['Cache-Control'] = ''
         @categories = Categories.find(:all )
         @titulo = "Categories"
         render :layout => "excel"
      end
  

   
   end
