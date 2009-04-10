class SituacaosController < ApplicationController
  
   before_filter :authorize
end
# GET /situacaos
# GET /situacaos.xml
def index
@situacaos = Situacao.find(:all)

respond_to do |format|
format.html # index.html.erb
format.xml  { render :xml => @situacaos }
end
end

# GET /situacaos/1
# GET /situacaos/1.xml
def show
@situacao = Situacao.find(params[:id])

respond_to do |format|
format.html # show.html.erb
format.xml  { render :xml => @situacao }
end
end

# GET /situacaos/new
# GET /situacaos/new.xml
def new
@situacao = Situacao.new

respond_to do |format|
format.html # new.html.erb
format.xml  { render :xml => @situacao }
end
end

# GET /situacaos/1/edit
def edit
@situacao = Situacao.find(params[:id])

end

# POST /situacaos
# POST /situacaos.xml
def create
@situacao = Situacao.new(params[:situacao])

respond_to do |format|
if @situacao.save
flash[:notice] = 'Situacao foi cadastrado com sucesso!'
format.html { redirect_to(@situacao) }
format.xml  { render :xml => @situacao, :status => :created, :location => @situacao }
else

format.html { render :action => "new" }
format.xml  { render :xml => @situacao.errors, :status => :unprocessable_entity }
end
end
end

# PUT /situacaos/1
# PUT /situacaos/1.xml
def update
@situacao = Situacao.find(params[:id])

respond_to do |format|
if @situacao.update_attributes(params[:situacao])
flash[:notice] = 'situacaos foi alterado com sucesso!'
format.html { redirect_to(@situacao) }

format.xml  { head :ok }
else

format.html { render :action => "edit" }
format.xml  { render :xml => @situacao.errors, :status => :unprocessable_entity }
end
end
end

# DELETE /situacaos/1
# DELETE /situacaos/1.xml
def destroy
@situacao = Situacao.find(params[:id])
@situacao.destroy

respond_to do |format|
format.html { redirect_to(situacaos_url) }
format.xml  { head :ok }
end
end
end
