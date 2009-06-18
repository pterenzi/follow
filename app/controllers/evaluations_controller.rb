class EvaluationsController < ApplicationController
  
  def create
    
  end

  def update
    debugger
    @task = Task.find(params[:task_id])
    @evaluation = Evaluation.last(:conditions=>["task_id=? and user_id=?", params[:task_id],@task.user_id])
    @task.refused = false
    if params[:task][:user].blank?
      @task.user_id = nil
    else
      @task.user_id = params[:task][:user]
    end
    @evaluation.evaluation_comment = params[:evaluation_comment]
    @evaluation.grade = params[:evaluation]  
    @task.alerta_requestor=false
    if @evaluation.save & @task.save
      flash[:notice] = "Avaliação gravada !"
      redirect_to tasks_path
    else
#YODO tratar excessão
    end
  end

end
