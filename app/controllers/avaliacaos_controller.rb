class AvaliacaosController < ApplicationController
  
  def create
    
  end

  def update
    debugger
    @task = Task.find(params[:task_id])
    @avaliacao = Avaliacao.last(:conditions=>["task_id=? and user_id=?", params[:task_id],@task.user_id])
    @task.recusada = false
    if params[:task][:user].blank?
      @task.user_id = nil
    else
      @task.user_id = params[:task][:user]
    end
    @avaliacao.comentario_avaliacao = params[:comentario_avaliacao]
    @avaliacao.nota = params[:avaliacao]  
    @task.alerta_solicitante=false
    if @avaliacao.save & @task.save
      flash[:notice] = "Avaliação gravada !"
      redirect_to tasks_path
    else
#YODO tratar excessão
    end
  end

end
