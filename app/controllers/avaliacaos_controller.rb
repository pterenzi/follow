class AvaliacaosController < ApplicationController
  
  def create
    
  end

  def update
    debugger
    @tarefa = Tarefa.find(params[:tarefa_id])
    @avaliacao = Avaliacao.last(:conditions=>["tarefa_id=? and user_id=?", params[:tarefa_id],@tarefa.user_id])
    @tarefa.recusada = false
    if params[:tarefa][:user].blank?
      @tarefa.user_id = nil
    else
      @tarefa.user_id = params[:tarefa][:user]
    end
    @avaliacao.comentario_avaliacao = params[:comentario_avaliacao]
    @avaliacao.nota = params[:avaliacao]  
    @tarefa.alerta_solicitante=false
    if @avaliacao.save & @tarefa.save
      flash[:notice] = "Avaliação gravada !"
      redirect_to tarefas_path
    else
#YODO tratar excessão
    end
  end

end
