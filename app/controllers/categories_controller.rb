class CategoriesController < ApplicationController
   
   before_filter :retrieve_tasks
   
#   require 'brazilian-rails'
   
   layout "layouts/follow" 

   # GET /categories GET /categories.xml
   def index
      @categories = Category.find(:all).from_client(session[:client])
      respond_to do |format|
         format.html # index.html.erb
         format.xml  { render :xml => @categories }
      end
   end

   # GET /categories/1 GET /categories/1.xml
   def show
     @category = Category.find(params[:id])
     @users = User.all(:conditions=>["category_id=?",@category.id], :order=>"name")
   end

   # GET /categories/new GET /categories/new.xml
   def new
      @category = Category.new
      respond_to do |format|
         format.html # new.html.erb
         format.xml  { render :xml => @categories }
      end
   end

   # GET /categories/1/edit
   def edit
     @category = Category.find(params[:id])
   end

   # POST /categories POST /categories.xml
   def create
     @category = Category.new(params[:category])
     respond_to do |format|
       if @category.save
         flash[:notice] = 'A categories foi cadastrada com sucesso!'
         format.html { redirect_to(@category) }
         format.xml  { render :xml => @category, :status => :created, :location => @categories }
       else
         format.html { render :action => "new" }
         format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
       end
     end
   end

      # PUT /categories/1 PUT /categories/1.xml
      def update
         @category = Category.find(params[:id])
         respond_to do |format|
            if @category.update_attributes(params[:category])
               flash[:notice] = 'A categories foi alterada com sucesso!'
               format.html { redirect_to(@category) }
               format.xml  { head :ok }
            else
               format.html { render :action => "edit" }
               format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
            end
         end
      end

      # DELETE /categories/1 DELETE /categories/1.xml
      def destroy
         @categories = Category.find(params[:id])
         name = @categories.name
         if @categories.destroy
            flash[:notice] = 'O categories ' + name + ' foi excluido com sucesso!'
         end

         respond_to do |format|
            format.html { redirect_to(categories_url) }
            format.xml  { head :ok }
         end
      end
   
   end
