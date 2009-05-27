# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
    helper :all # include all helpers, all the time
    helper_method :current_user_session, :current_user
    filter_parameter_logging :password, :password_confirmation

    private
      def current_user_session
        return @current_user_session if defined?(@current_user_session)
        @current_user_session = UserSession.find
      end

      def current_user
        return @current_user if defined?(@current_user)
        @current_user = current_user_session && current_user_session.record
      end

      def require_user
        unless current_user
          store_location
          flash[:notice] = "Por favor, autentique-se"
          redirect_to new_user_session_url
#          redirect_to(:controller => "login", :action => "login")
          return false
        end
      end

      def require_no_user
        if current_user
          store_location
          flash[:notice] = "Por favor, autentique-se"
          redirect_to account_url
          return false
        end
      end

      def store_location
        session[:return_to] = request.request_uri
      end

      def redirect_back_or_default(default)
        redirect_to(session[:return_to] || default)
        session[:return_to] = nil
      end

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'bedba74a46c096afc1a91e84baea730e'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password


  def busca_tarefas
     @tarefas = Tarefa.find(:all)
     @minhas_solicitacoes = Tarefa.all(:order=>"user_id", 
           :conditions=>["avaliacao is null and solicitante_id=? and user_id<>solicitante_id and user_id not null",current_user.id ])
     @minhas_tarefas = Tarefa.all(:order=>"solicitante_id", :conditions=>["recusado<>'t' and termino_at is null and user_id <> solicitante_id and user_id=?  ",current_user.id])
     @tarefas_sem_usuario = Tarefa.all(:conditions=>["solicitante_id=? and user_id is null ",current_user.id])
     @andamentos = Andamento.all(:conditions=> ["ativo=?",true]).collect{|obj| [obj.nome,obj.nome]}
     @pausas_padrao = PausaPadrao.all(:order=>"descricao").collect{|obj| [obj.descricao,obj.id]}
     @tem_tarefa_com_pausa_padrao = Tarefa.tem_tarefa_com_pausa_padrao(@minhas_tarefas)
     @tarefas_encerradas_sem_avaliacao = Tarefa.all(:conditions=>["termino_at is null and avaliacao is null and solicitante_id=?  ",current_user.id])
     @usuarios = User.find(:all).collect{|obj| [obj.nome,obj.id]}
     @to_do_list = Tarefa.all(:order=>"id", :conditions=>["termino_at is null and user_id = solicitante_id and user_id=?  ",current_user.id])
  #TODO testar <> 't' em outros bancos
   end
   
   private

  def authorize
    if session[:user_id].nil? || user.find(session[:user_id]).nil? 
       session[:original_uri] = request.request_uri
      flash[:notice] = "Por favor autentique-se"
      redirect_to(:controller => "login", :action => "login")
    end
  end

end
