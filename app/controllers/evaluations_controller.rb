class EvaluationsController < ApplicationController
  
  def create
    
  end
  
  def edit
    @evaluation = Evaluation.last(:conditions=>["task_id=? and user_id=?", params[:task_id],@task.user_id])
  end

  def update
    #TODO ao finalizar uma tarefa, fazer com que a mesma comece a piscar na tela do requestor
    #TODO definir user_id para update de evaluation
    @task = Task.find(params[:task_id])
    @evaluation = Evaluation.last(:conditions=>["task_id=? and user_id=?", params[:task_id],@task.user_id])
    @task.refused = false
    debugger
    #TODO pra que setar o user_id ?
    if params[:user_id].blank?
      @task.user_id = nil
    else
      @task.user_id = params[:user_id]
    end
    @evaluation.evaluation_comment = params[:evaluation_comment]
    @evaluation.grade = params[:evaluation]  
    @task.requestor_alert=false
    if @evaluation.save & @task.save
      flash[:notice] = "Avaliação gravada !"
      redirect_to tasks_path
    else
#YODO tratar excessão
    end
  end

end
