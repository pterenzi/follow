class LoginController < ApplicationController


  before_filter :authorize, :except => [:login, :add_usuario]
   
  layout "layouts/follow"
  

  def index
    
  end

  def show
    @usuario = Usuario.find(params[:id])
  end

  # just display the form and wait for usuario to enter a name and password
  
  def login
    reset_session
    session[:usuario_id] = nil
    if request.post?
      usuario = Usuario.authenticate(params[:name], params[:password])
      if usuario
        session[:usuario_id] = usuario.id
        session[:perfil] = usuario.categoria.nome
        redirect_to( url_for :controller => 'tarefas', :action => 'index' )
      else
        flash.now[:notice] = "Senha ou Login invalido!"
      end
    end
  end
  

  
  def add_usuario
    @usuario = Usuario.new(params[:usuario])
    @categorias = Categoria.find(:all).collect{|obj| [obj.nome,obj.id]}
    if request.post? and @usuario.save
      flash.now[:notice] = "Usuario #{@usuario.nome} criado"
      @usuario = Usuario.new
    end
  end

  def edit
     
    @usuario = Usuario.find(params[:id])
    @categorias = Categoria.find(:all).collect{|obj| [obj.nome,obj.id]}
      
    if request.post? and @usuario.update_attributes(params[:usuario])
      flash.now[:notice] = "Usuario #{@usuario.nome} alterado"
      redirect_to(url_for(:action => 'list_usuarios'), :controller => 'login')
    end
  end

  # . . .
  

  def delete_usuario
    id = params[:id]
    if id && usuario = Usuario.find(id)
      begin
        usuario.destroy
        flash[:notice] = "Usuario #{usuario.nome} excluido"
      rescue Exception => e
        flash[:notice] = e.message
      end
    end
    redirect_to( :controller => 'login', :action => 'list_usuarios')
  end

  def list_usuarios
    @usuarios = Usuario.find(:all)
  end

  def logout
    session[:usuario_id] = nil
    session[:perfil] = nil
    reset_session
    flash[:notice] = "Logged out"
    redirect_to(:action => "login")
  end

end
