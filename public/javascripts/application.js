// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//$.ui.dialog.defaults.bgiframe = true;

$(document).ready(function(){
  // $("#datepicker").datepicker();
   $(".datetime").datepicker({
     duration: '',
     showTime: true,
     constrainInput: false,
     time24h: true,
     stepMinutes: 5  
    });
 });


function abre_form_pause(id){
    $('#form_pause_'+id).dialog({ title: 'Pausar tarefa' });
    $('#form_pause_'+id).dialog('open');
    $('#form_pause_'+id).dialog();
};

function abre_form_approve_disapprove_pause(id){
    $('#form_aprovar_pause_'+id).dialog({ title: 'Aprovar / Reprovar Pausa' });
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
    $('#abre_end_'+id).dialog({ title: 'Encerrar tarefa' });
    $('#abre_end_'+id).dialog('open');
    $('#abre_end_'+id).dialog();
}

function abre_form_evaluation(id){
    $('#abre_evaluation_'+id).dialog({ title: 'Avaliação' });
    $('#abre_evaluation_'+id).dialog('open');
    $('#abre_evaluation_'+id).dialog();
}

function abre_form_recusa(id){
    $('#form_recusa_'+id).dialog({ title: 'Recusar tarefa' });
    $('#form_recusa_'+id).dialog('open');
    $('#form_recusa_'+id).dialog();
}

function abre_alerta_recusado(id){
    $('#form_task_refused_'+id).dialog({ title: 'Tarefa recusada' });
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

function include_user(id,user_id, user_name,controller){
    $.get("/"+controller + "/insert_user",{'id': id, 'user_id': user_id});
    onClick="remove_user("+ id + "," + user_id + ",'" + user_name + "')"
    span = "<span id=\"selected_"+ user_id + "\">"
    str = span + "<a href='#' onClick=\"" + onClick + "\">" + user_name + "</a><br/></span>";
    $("#selected_users").append(str);
    $("#not_selected_"+user_id).remove();
    $("#event_method").remove();
}

function remove_user(id,user_id, user_name,controller){
 $.get("/"+controller+"/remove_user",{'id': id, 'user_id': user_id});
    onClick="include_user("+ id + "," + user_id + ",'" + user_name + "')"
    span = "<span id=\"not_selected_"+ user_id + "\">"
    str = span + "<a href='#' onClick=\"" + onClick + "\">" + user_name + "</a><br/></span>";
    $("#not_selected_users").append(str);
    $("#selected_"+user_id).remove();
}

function remove_message(id){
  $.get("/messages/mark_as_readed",{'id': id});
  $("#message_"+id).remove();
}

function filter_user(user_group_id){
  $("#not_selected_users").html("");
    $.getJSON("/user_groups/retrieve_users",{'company_id': $("#company_id").val(),
  'project_id': $("#project_id").val(),'user_group_id': user_group_id },
         function(data){
        list = ""
      for (var i = 0; i < data.length; i++){
              list = list + "<a href='#' onClick='include_user(" + user_group_id + "," + 
  data[i][0] + "," + data[i][1] + ",'user_groups')>"+ data[i][0]+ "</a><br/>"
            }
          $("#not_selected_users").html(list);
    });
}
function project_selected(){
  $("#task_user_id").hide();
    $.getJSON("/users/retrieve_users",{'company_id': $("#company_id").val(),
'project_id': $("#project_id").val(),'user_group_id': $("#user_group_id").val() },
       function(data){
            $("#task_user_id").html("<option value=''>Selecione um colaborador</option>");
            saida = "";
            for (var i = 0; i < data.length; i++){
              saida = saida + data[i];
              $("#task_user_id").append(new Option(data[i][0],data[i][1]));
            }
            if (data.length>0) {
        $("#task_user_id").show();
            }else{
        $("#task_user_id").hide();
            }
       }
    );
}

function populate_user_select(element){
//  alert(element);
  $("#"+element).hide();
    $.getJSON("/users/retrieve_users",{'company_id': $("#company_id").val(),
'project_id': $("#project_id").val(),'user_group_id': $("#user_group_id").val() },
       function(data){
            $("#"+element).removeOption(/./);
            saida = "";
            for (var i = 0; i < data.length; i++){
              saida = saida + data[i];
              $("#"+element).append(new Option(data[i][0],data[i][1]));
            }
            if (data.length>0) {
        $("#"+element).show();
            }else{
        $("#"+element).hide();
            }
       }
    );
}

function open_info_task(task_id){
   $('#info_task_'+task_id).dialog({ title: 'Detalhes da tarefa' });
   $('#info_task_'+task_id).dialog('open');
   $('#info_task_'+task_id).dialog();
}
