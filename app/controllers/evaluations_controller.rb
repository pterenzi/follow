class EvaluationsController < ApplicationController
  
  layout "follow"
  before_filter :retrieve_tasks , :only=>[:report]
  
  def edit
    @evaluation = Evaluation.last(:conditions=>["task_id=? and user_id=?", params[:task_id],@task.user_id])
  end

  def update
    @task = Task.find(params[:task_id])
    @evaluation = Evaluation.last(:conditions=>["task_id=? and user_id=?", params[:task_id],@task.user_id])
    @task.refused = false
    
    @evaluation.comment = params[:comment]
    @evaluation.grade = params[:evaluation]  
    @task.requestor_alert=false
    if @evaluation.save & @task.save
      flash[:notice] = "Avaliação gravada !"
      redirect_to tasks_path
    else
#TODO tratar excessão
    end
  end
  
  def report
    @search_type = params[:search_type]
    @users = [t(:all)]
    @users +=  User.by_name.from_client(current_user.client_id).collect{|obj| [obj.name,obj.id.to_s]}
    @tasks = []
    if params[:user_id]
      @searched_user = t(:all)
      if @search_type == "user"
        if params["user_id"].to_i > 0
          @searched_user = User.find(params[:user_id]).name
          @tasks = Task.encerradas.para_mim(current_user.id).solicitadas_por(params[:user_id].to_i)
        else
          @tasks = Task.encerradas.para_mim(current_user.id)
        end
      else
        if params[:user_id].to_i > 0
          @searched_user = User.find(params[:user_id]).name
          @tasks = Task.encerradas.solicitadas_por(current_user.id).for_user(params[:user_id].to_i)
        else
          @tasks = Task.encerradas.solicitadas_por(current_user.id)
        end
      end  
    end
  end

end
