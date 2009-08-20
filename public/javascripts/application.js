// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$.ui.dialog.defaults.bgiframe = true;

function abre_form_pause(id){
    $('#form_pause_'+id).dialog({ title: 'Pause' });
    $('#form_pause_'+id).dialog('open');
    $('#form_pause_'+id).dialog();
};

function abre_form_approve_disapprove_pause(id){
    $('#form_aprovar_pause_'+id).dialog({ title: 'Aprovar / Reprovar Pause' });
    $('#form_aprovar_pause_'+id).dialog('open');
    $('#form_aprovar_pause_'+id).dialog();
}

function toggle(task_id,muda_alerta,origem){
  if (muda_alerta){
    $.get("/tasks/change_alert",{'id': task_id, 'valor': "false", 'campo': origem});

  }
    parar_pulsar('#blink_'+task_id);
  $('#toggle_appear_'+ task_id).toggle('blind', { percent: 0 },500 ); 
  return false;
};

function abre_form_end(id){
    $('#abre_end_'+id).dialog({ title: 'Término' });
    $('#abre_end_'+id).dialog('open');
    $('#abre_end_'+id).dialog();
}

function abre_form_evaluation(id){
    $('#abre_evaluation_'+id).dialog({ title: 'Avaliação' });
    $('#abre_evaluation_'+id).dialog('open');
    $('#abre_evaluation_'+id).dialog();
}

function abre_form_recusa(id){
    $('#form_recusa_'+id).dialog({ title: 'Recusar' });
    $('#form_recusa_'+id).dialog('open');
    $('#form_recusa_'+id).dialog();
}

function abre_alerta_recusado(id){
    $('#form_task_refused_'+id).dialog({ title: 'Task refused' });
    $('#form_task_refused_'+id).dialog('open');
    $('#form_task_refused_'+id).dialog();
}

function task_detail(id){
    $('#detail_form_'+id).dialog({ title: "Detalhes da tarefa" });
    $('#detail_form_'+id).dialog('open');
    $('#detail_form_'+id).dialog();
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

function remove_message(id){
  $.get("/messages/mark_as_readed",{'id': id});
  $("#message_"+id).remove();
}

function new_event(data){
	alert("new event " + data);
}