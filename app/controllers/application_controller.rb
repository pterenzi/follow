# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
    helper :all # include all helpers, all the time
    helper_method :current_user_session, :current_user
    filter_parameter_logging :password, :password_confirmation
    before_filter :find_client, :set_locale
    
    
    def find_client
      return if session[:super_user]
      if session[:client_id]
        @client= Client.find(session[:client_id])
      else
        @client = Client.find_by_name(params[:client])
      end
    end
    
    def set_locale
      if params[:locale]
        I18n.locale = params[:locale]
      #else
      #  I18n.locale = "pt-BR"
      end
    end
    
    def default_url_options(options={})
      logger.debug "default_url_options is passed options: #{options.inspect}\n"
      if session[:client_id]
        
        { :locale => I18n.locale, :client=>@client.name }
      else
        { :locale => I18n.locale }
      end
    end
    
    private
    
      def verify_super_user
        if !session[:super_user]
          redirect_to :login_super_user
        end
      end
      
      def current_user_session
        return @current_user_session if defined?(@current_user_session)
        @current_user_session = UserSession.find
      end

      def current_user
        return @current_user if defined?(@current_user)
        @current_user = current_user_session && current_user_session.record
      end

      def require_user
        return true if session[:super_user]
        unless current_user
          store_location
          flash[:notice] = "Por favor, autentique-se"
          if params[:client]
            redirect_to new_user_session_url(:client=>params[:client])
          else
            redirect_to new_user_session_url
          end
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


  def retrieve_tasks
    @pauses_pattern = PatternPause.all(:order=>"description").collect{|obj| [obj.description,obj.id]}
    @tem_task_com_pattern_pause = Task.tem_task_com_pattern_pause(@my_tasks)
    @tasks_encerradas_sem_evaluation = Task.encerradas_sem_evaluation(current_user.id) #Task.all(:conditions=>["end_at is not null and requestor_id=?  ",current_user.id])
    @users = User.by_name.from_client(current_user.client_id).collect{|obj| [obj.name,obj.id]}
    
    #Com named_scope
    @projects = Project.by_name.from_client(current_user.client_id).collect{|obj| [obj.description,obj.id]}
    @my_tasks = Task.para_mim(current_user.id).abertas.por_requestor.sem_recusa.ordenados
    @my_requests = Task.abertas.solicitadas_por(current_user.id).with_user_defined.not_mines(current_user.id)
    @my_requests = @my_requests + @tasks_encerradas_sem_evaluation
    @tasks_without_user = Task.solicitadas_por(current_user.id).sem_user
    @to_do_list = Task.abertas.de_mim_para_mim(current_user.id)    
    @messages_list = Message.not_readed(current_user).order_by_created_at
    @events = Event.find(:all, :conditions=>["user_id=?",current_user.id])
    @date_calendar = Date.today
    @event = Event.new
    @evaluation = Evaluation.new
    @client = current_user.client
   end
   
end
