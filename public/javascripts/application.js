// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$.ui.dialog.defaults.bgiframe = true;

$(document).ready(function(){
    
//  $('#dialog').hide();
    $("pausa").click(function(event){
       alert('entrou');
    });
});

function abre_form_pausa(id){
    $('#form_pausa_'+id).dialog({ title: 'Pausa' });
    $('#form_pausa_'+id).dialog('open');
    $('#form_pausa_'+id).dialog();
};

function abre_form_aprovar_reprovar_pausa(id){
    $('#form_aprovar_pausa_'+id).dialog({ title: 'Aprovar / Reprovar Pausa' });
    $('#form_aprovar_pausa_'+id).dialog('open');
    $('#form_aprovar_pausa_'+id).dialog();
}

function toggle(task_id,muda_alerta,origem){
  if (muda_alerta){
    $.get("/tasks/mudar_alerta",{'id': task_id, 'valor': "false", 'campo': origem});
    parar_pulsar('#blink_'+task_id);
  }
  $('#toggle_appear_'+ task_id).toggle('blind', { percent: 0 },500 ); 
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

function abre_form_recusa(id){
    $('#form_recusa_'+id).dialog({ title: 'Recusar' });
    $('#form_recusa_'+id).dialog('open');
    $('#form_recusa_'+id).dialog();
}

function abre_alerta_recusado(id){
	$('#form_task_recusada_'+id).dialog({ title: 'Task recusada' });
    $('#form_task_recusada_'+id).dialog('open');
    $('#form_task_recusada_'+id).dialog();
}

function detalhe_task(id){
    $('#form_detalhe_'+id).dialog({ title: 'Detalhe da task' });
    $('#form_detalhe_'+id).dialog('open');
    $('#form_detalhe_'+id).dialog();
}

function pulsar(id){
    $(id).pulse({
        textColor: ['black','yellow','white'],
        opacityRange: [0.3, 1.3]
    });
}

function parar_pulsar(id){
    $(id).recover();
}

function include_user(id,user_id, user_name){
    $.get("/projects/insert_user",{'id': id, 'user_id': user_id});
    onClick="remove_user("+ id + "," + user_id + ",'" + user_name + "')"
    span = "<span id=\"selected_"+ user_id + "\">"
    str = span + "<a href='#' onClick=\"" + onClick + "\">" + user_name + "</a><br/></span>";
    $("#selected_users").after(str);
    $("#not_selected_"+user_id).remove();
}

function remove_user(id,user_id, user_name){
    $.get("/projects/remove_user",{'id': id, 'user_id': user_id});
	onClick="include_user("+ id + "," + user_id + ",'" + user_name + "')"
    span = "<span id=\"not_selected_"+ user_id + "\">"
    str = span + "<a href='#' onClick=\"" + onClick + "\">" + user_name + "</a><br/></span>";
    $("#not_selected_users").after(str);
    $("#selected_"+user_id).remove();
    
}