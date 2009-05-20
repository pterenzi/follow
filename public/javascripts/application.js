// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$.ui.dialog.defaults.bgiframe = true;

$(document).ready(function(){
	
//	$('#dialog').hide();
    $("pausa").click(function(event){
	   alert('entrou');
    });
});

function abre_form_pausa(id){
	$('#form_pausa_'+id).dialog({ title: 'Pausa' });
	$('#form_pausa_'+id).dialog('open');
	$('#form_pausa_'+id).dialog();
};


function toggle(toggle_id,tarefa_id,muda_alerta,origem){
  if (muda_alerta){
	$.get("/tarefas/mudar_alerta",{'id': tarefa_id, 'valor': "false", 'campo': origem});
	$("#blink_" + tarefa_id).remove();
  }
  $(toggle_id).toggle('blind', { percent: 0 },500 ); 
  return false;
};

function abre_form_termino(id){
  	$('#abre_termino_'+id).dialog({ title: 'Término' });
	$('#abre_termino_'+id).dialog('open');
	$('#abre_termino_'+id).dialog();
}

function abre_form_avaliacao(id){
  	$('#abre_avaliacao_'+id).dialog({ title: 'Avaliação' });
	$('#abre_avaliacao_'+id).dialog('open');
	$('#abre_avaliacao_'+id).dialog();
	
}

