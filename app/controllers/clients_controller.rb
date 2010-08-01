class ClientsController < ApplicationController

  layout "admin"
  
  before_filter :verify_super_user, :except=>[:select_client]

  # GET /clients
  # GET /clients.xml
  def index
    @clients = Client.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clients }
    end
  end

  # GET /clients/1
  # GET /clients/1.xml
  def show
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.xml
  def new
    @client = Client.new
    @client.valid_until = Date.today + 15.days
    @client.active = true
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
  end

  # POST /clients
  # POST /clients.xml
  def create
    @client = Client.new(params[:client])
    @company = Company.create(:name=>params[:client][:name])
    @client.companies << @company
#    @client.company << @company #TODO 1) salvar companya e depois associar a client
    respond_to do |format|
      if @client.save #and @company.save
        flash[:notice] = 'Client was successfully created.'
        format.html { redirect_to(@client) }
        format.xml  { render :xml => @client, :status => :created, :location => @client }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.xml
  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        flash[:notice] = 'Client was successfully updated.'
        format.html { redirect_to(@client) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @client.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.xml
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to(clients_url) }
      format.xml  { head :ok }
    end
  end
  
  def manage_users
    @client = Client.find(params[:client_id])
  end
  
  def new_user
   @client = Client.find(params[:client_id])  
   @company = @client.companies.first
   @user = User.new
   @user.client_id = params[:client_id]
   @user.company_id = @company.id
   @user.preferred_language = "pt-BR"
   @user.password="1234"
   @user.password_confirmation = "1234"
  end
  
  def create_user
   
    @user = User.new(params[:user])
    @user.role_id = 1
    if @user.save
     flash[:notice] = "Usuário criado !"
     redirect_to clients_path
    else
      @client = Client.find(params[:user][:client_id])
      render :action => :new_user
    end
  end
  
  def select_client
    @clients = Client.all(:order=>:name, :conditions=>["active = ?", true])
  end
end
