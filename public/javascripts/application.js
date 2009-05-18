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
	//alert('entrou aqui');
	$('#form_pausa_'+id).dialog({ title: 'Pausa' });
	$('#form_pausa_'+id).dialog('open');
	$('#form_pausa_'+id).dialog();
};


function toggle(toggle_id,tarefa_id,muda_alerta){
  if (muda_alerta){
//	$.get("/tarefas/mudar_alerta",{'id': tarefa_id, 'valor': "false", 'campo': "solicitante"});
	$("#blink_" + tarefa_id).remove();
//	alert("mudar alerta da tarefa " + tarefa_id  );
}
  $(toggle_id).toggle('blind', { percent: 0 },500 ); 
  return false;
};

