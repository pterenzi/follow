# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
    helper :all # include all helpers, all the time
    helper_method :current_user_session, :current_user
    filter_parameter_logging :password, :password_confirmation
    before_filter :set_locale
    
    def set_locale
      I18n.locale = params[:locale]
    end
    
    def default_url_options(options={})
      logger.debug "default_url_options is passed options: #{options.inspect}\n"
      { :locale => I18n.locale }
    end
    
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
          redirect_to tasks_path
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


  def busca_tasks
    @pausas_padrao = PausaPadrao.all(:order=>"descricao").collect{|obj| [obj.descricao,obj.id]}
    @tem_task_com_pausa_padrao = Task.tem_task_com_pausa_padrao(@minhas_tasks)
    @tasks_encerradas_sem_avaliacao = Task.encerradas_sem_avaliacao(current_user.id) #Task.all(:conditions=>["termino_at is not null and solicitante_id=?  ",current_user.id])
    @usuarios = User.find(:all).collect{|obj| [obj.nome,obj.id]}
    
    #Com named_scope
    @projetos = Projeto.all(:order=>'descricao').collect{|obj| [obj.descricao,obj.id]}
    @minhas_tasks = Task.para_mim(current_user.id).abertas.por_solicitante.sem_recusa
    @minhas_solicitacoes = Task.busca_minhas_solicitacoes(current_user.id)
    @tasks_sem_usuario = Task.solicitadas_por(current_user.id).sem_user
    @to_do_list = Task.abertas.de_mim_para_mim(current_user.id)    
   
     #TODO colocar isto em minhas tasks   recusada<>'t' and
     #TODO testar <> 't' em outros bancos
   end
   
end
