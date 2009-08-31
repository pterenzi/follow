function new_event(data){
//	$.get("/events/new");
    comps = data.split("-");
    $("#event_date_3i").selectOptions(parseInt(comps[2],10)+"");
    $("#event_date_2i").selectOptions(parseInt(comps[1],10)+"");
    $('#event_content').focus();
}

function edit_event(event_id,event_content,data){
//alert(data);   
 //comps = data.split("-");
 // $("#event_date_3i").selectOptions(parseInt(comps[2],10)+"");
 //   alert("editing event " + event_id + " / " + event_content);
 // $("#event_date_2i").selectOptions(parseInt(comps[1],10)+"");
 //  $("#event_content").val(event_content);
 //  $("#event_id").val(event_id);
 // $("#event_submit").val("Update");
//<input name="_method" type="hidden" value="put" />
}

function display_calendar(){
   // alert("display");
   // $.get("/events/display_calendar");
}