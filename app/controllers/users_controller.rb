class UsersController < ApplicationController

# TODO colocar layout em users
  layout "follow"
#TODO retirar o comentario abaixo
  before_filter :require_user
  before_filter :busca_tasks, :only=>[:new]
   
  def new
    @user = User.new
    @categorias = Categoria.all(:order=>"nome").collect{|obj| [obj.nome,obj.id]}
  end
  
  def create
    debugger
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Usuário criado !"
      redirect_to tasks_path
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
      redirect_to tasks_path
    else
      render :action => :edit
    end
  end
end
