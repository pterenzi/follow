# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'bedba74a46c096afc1a91e84baea730e'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password


  def busca_tarefas
     @tarefas = Tarefa.find(:all)
     @minhas_solicitacoes = Tarefa.all(:order=>"usuario_id", 
           :conditions=>["solicitante_id=? and usuario_id<>solicitante_id and usuario_id<>''",@usuario_logado.id ])
     @minhas_tarefas = Tarefa.all(:order=>"solicitante_id", :conditions=>["usuario_id=?  ",@usuario_logado.id])
     @tarefas_sem_usuario = Tarefa.all(:conditions=>["solicitante_id=? and usuario_id='' ",@usuario_logado.id])
     @andamentos = Andamento.all(:conditions=> ["ativo=?",true]).collect{|obj| [obj.nome,obj.nome]}
     @pausas_padrao = PausaPadrao.all(:order=>"descricao").collect{|obj| [obj.descricao,obj.id]}
     @tem_tarefa_com_pausa_padrao = Tarefa.tem_tarefa_com_pausa_padrao(@minhas_tarefas)
   end
   
   private

  def authorize
#    debugger
    if session[:usuario_id].nil? || Usuario.find(session[:usuario_id]).nil? 
       session[:original_uri] = request.request_uri
      flash[:notice] = "Por favor autentique-se"
      redirect_to(:controller => "login", :action => "login")
    end
  end

end
