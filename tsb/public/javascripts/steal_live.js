$(document).ready(function() {
   jQuery(function($){
       $("#sms_form1").bind('ajax:complete', function() {  $("#popup1").dialog('close');});
       $("#sms_form1").bind('ajax:beforeSend', function(evt, xhr, settings){ $("#popup1").dialog('close');});
       $("#sms_form2").bind('ajax:complete', function() {  $("#popup6").dialog('close');});
       $("#sms_form2").bind('ajax:beforeSend', function(evt, xhr, settings){ $("#popup6").dialog('close');});
       $("#mail_form").bind('ajax:complete', function() {  $("#popup1").dialog('close');});
       $("#mail_form").bind('ajax:success', function(data, status, xhr) {
         if ( status['response'] ){ 
           $("#email_id").val("");
           $("#popup2").dialog("close");
           $("#popup4").dialog({ modal:true ,resizable: false, dialogClass: 'sms_popup'});   
          } 
          else{
           $("#email_id").val("");
           $("#popup2").dialog("close");    
           $("#popup3").dialog({ modal:true ,resizable: false, dialogClass: 'sms_popup' });           
          }     
       });
       $("#mail_form_below").bind('ajax:complete', function() {  $("#popup5").dialog('close');});
       $("#mail_form_below").bind('ajax:success', function(data, status, xhr) {
         if ( status['response'] ){ 
           $("#email_id_below").val("");
           $("#popup5").dialog("close");
           $("#popup4").dialog({ modal:true ,resizable: false, dialogClass: 'sms_popup'});   
          } 
          else{
           $("#email_id_below").val("");
           $("#popup2").dialog("close");    
           $("#popup3").dialog({ modal:true ,resizable: false, dialogClass: 'sms_popup'});           
          }     
       });       
   });
 }); 

function sms_pop_up(){
 $("#popup1").dialog({ modal:true ,resizable: false, dialogClass: 'sms_popup'});
}

function sms_pop_up_steal_code(){
 $("#popup6").dialog({ modal:true ,resizable: false, dialogClass: 'sms_popup'});
}


function sendmail_pop_up(){
 $("#popup2").dialog({ modal:true ,resizable: false});
}
function sendmail_pop_up_below(){
 $("#popup5").dialog({ modal:true ,resizable: false });
}
