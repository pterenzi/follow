// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$.ui.dialog.defaults.bgiframe = true;

$(document).ready(function(){
    
//  $('#dialog').hide();
    $("pause").click(function(event){
       alert('entrou');
    });
});



$(window).load(function () {
	$.timer(5000, function(timer){
	    $.getJSON("/tasks/verify_updates_rjs");
	});
    $.timer(60000, function (timer) {
    $.getJSON("/tasks/verify_updates",  function(data){
    task_str = '<div id="task"><span id="blink_'+ data.task.id + '" >' + 
    '<a href="#"  title="Detalhes da task" onClick="task_detail('+ data.task.id + ');"><img src="images/info.png" border=""</a>' +
    '<a href="#" onClick=toggle('+ data.task.id + ',"true","usuario") ><span class"hyphanate" lang="pt">&nbsp;'+
    data.task.description + 
    '</span></a></span>'+
    '<div style="display: none;"id="toggle_appear_' + data.task.id + '" style="background:#F2F2F2;">'+
    '<table width="80" border="0" cellspacing="0" cellpadding="0">'+
    '<tr> <td height= "20" align="botton" ><p class="link"><a href="#" onClick="abre_form_recusa('+data.task.id + ');return false;" style="text-decoration:none"' +
    ' OnMouseOver="document.devolver.src=images/backwardh.png" OnMouseOut="document.devolver.src=images/backward.png">'+
    '<Img Src="images/backward.png" Name="devolver" Width="18" Height="10" Border="">'+
    '<span>Não aceitar esta task</span></a></p></td>' +
    '<td height= "20" align="botton"><p class="link"> <a href="#" onClick="abre_form_pause('+ data.task.id + ');return false;" '+
    'style="text-decoration:none" OnMouseOver="document.pause.src=images/pauseh.png" '+ 
    ' OnMouseOut="document.pause.src=images/play.png"><Img Src="images/play.png" Name="pause" Width="18" Height="10"Border="">'+
    '<span>Pausar esta task</span></a></p></td>'+
    '<td height= "20" align="botton" ><p class="link"><a Href="#" style="text-decoration:none"'+
    ' OnMouseOver="document.foward.src=images/fowardh.png" OnMouseOut="document.foward.src=images/foward.png">'+
    '<Img Src="images/foward.png" Name="foward" Width="18" Height="10"Border=""><span>Reencaminhar</span></a></p></td>' +
    '<td height= "20" align="botton"><p class="link"> <a href="#" onClick="abre_form_end('+data.task.id + ');return false;" '+
    'style="text-decoration:none" OnMouseOver="document.stop.src=images/stoph.png" OnMouseOut="document.stop.src=images/stop.pn">'+ 
    '<Img Src="images/stop.png" Name="stop" Width="18" Height="10"Border=""><span>Finalizar</span></a></p></td>' +
    '</tr></table></span></a>' + 
    '<form action="/comments?locale=en" method="post"><div style="margin:0;padding:0"><input name="authenticity_token" type="hidden" value="13b583a42ebdb356ed410442d07699934b157f37" /></div> '+
    '<input id="task_id" name="task_id" type="hidden" value="'+ data.task.id + '" />'+
    ' <p> <br/> <textarea cols="22" id="description" name="description" rows="3"></textarea> </p>'+
    ' <p> <br/><input name="commit" type="submit" value="Send comment" /> </p></form>' +
    '<div style="display:none;" id="form_pause_'+ data.task.id + '"> ' +
    '<form action="/tasks/create_pauser?locale=en" method="post"><div style="margin:0;padding:0"><input name="authenticity_token" type="hidden" value="13b583a42ebdb356ed410442d07699934b157f37" /></div>'+
      '<input id="task_id" name="task_id" type="hidden" value="30" /> <table><tr> '+
       '<td valign="top">Justificativa :&nbsp; </td> ' +
       '<td><textarea cols="21" id="justification" name="justification" rows="2"></textarea></td> '+
       '</tr><tr><td>&nbsp;</td><td><br/><input name="commit" type="submit" value="Pauser task" /></td></tr></table> '+
      '</form> '+
     '</div>' +
     '<div style="display:none;" id="form_recusa_'+ data.task.id + '">'+
        '<form action="/tasks/recusar_task?locale=en" method="post"><div style="margin:0;padding:0"><input name="authenticity_token" type="hidden" value="13b583a42ebdb356ed410442d07699934b157f37" /></div>' +
          '<input id="task_id" name="task_id" type="hidden" value="'+ data.task.id + '" />'+
          '<table><tr><td valign="top">Justificativa :&nbsp; </td> ' + 
            '<td><textarea cols="21" id="justification" name="justification" rows="2"></textarea></td> </tr><tr><td>&nbsp;</td>'+ 
            '<td><br/><input name="commit" type="submit" value="Recusar task" /></td>' + 
            '</tr>'+
          '</table></form>'+ 
      '</div>' +
      '<div style="display:none;" id="abre_end_' + data.task.id + '">'+
         '<form action="/tasks/encerrar_task?locale=en" method="post"><div style="margin:0;padding:0"><input name="authenticity_token" type="hidden" value="13b583a42ebdb356ed410442d07699934b157f37" /></div>' +
         '<input id="id" name="id" type="hidden" value="' + data.task.id + '" />'+ 
         '<h1> Tem certeza que deseja encerrar esta task ? </h1><p> '+
         'Comentário :<br/> '+
         '<textarea cols="22" id="comment_end" name="comment_end" rows="3"></textarea>' +
         '</p><p><br/><input name="commit" type="submit" value="Encerrar task" />' +
         '</p></form>' + 
       '</div>' +
    '</div>'  
//    alert (task_str);
    $("#user_id_"+data.task.requestor_id).after(task_str);
    //pulsar(data.task.id);
 //   $("blink_"+data.task.id).pulse({
 //       textColor: ['black','yellow','white'],
 //       opacityRange: [0.3, 1.3]
 //   }
        }
    );
//  timer.stop();
  });
});

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
    parar_pulsar('#blink_'+task_id);
  }
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