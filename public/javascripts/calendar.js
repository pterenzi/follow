function new_event(data){
//	$('#event_form').hide();
 //   comps = data.split("-");
 //   $("#event_date_3i").selectOptions(parseInt(comps[2],10)+"");
 //   $("#event_date_2i").selectOptions(parseInt(comps[1],10)+"");
 //   $('#event_content').focus();
 //   $('#event_content').val('');
	$.get("/events/new");
}
