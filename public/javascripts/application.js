// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function alerta(id){
    alert($('andamento_id').value);
    alert(id);
    if $('andamento_id')=='Pausar'{
      alert("clicou em pausar");  
      onClick=Effect.toggle('toggle_appear_'+id , 'blind', { duration: 1.0 } ); return false;
    }
}