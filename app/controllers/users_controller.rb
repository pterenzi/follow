class UsersController < ApplicationController


  layout "follow"
  
#  before_filter :require_no_user, :only => [:new, :create]
#  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :require_user
   
  def new
    @user = User.new
    @categorias = Categoria.all(:order=>"nome").collect{|obj| [obj.nome,obj.id]}
  end
  
  def create
    debugger
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Usuário criado !"
      redirect_to tarefas_path
    else
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end
 
  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to tarefas_path
    else
      render :action => :edit
    end
  end
end
