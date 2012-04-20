$(document).ready(function(){

function change_select_text(val) 
  {  
  	 document.getElementById('select6').innerHTML = val;
  }
  
  function change_date_text(val) 
  {
  	 document.getElementById('select7').innerHTML = val; 
  }
  
  function change_month_text(val)
  {
  	 document.getElementById('select8').innerHTML = val;
  }

  function change_year_text(val)
  {
  	 document.getElementById('select9').innerHTML = val; 
  }

  function change_state_text(val)  
  {
  	 document.getElementById('select10').innerHTML = val; 
  }
       
  $('.year_styled').change(function(event) {
      $('#select9').html($('.year_styled option:selected').text());
  });        
  $('#member_form_gender').change(function(event) {
      $('#select6').html($('#member_form_gender option:selected').text());
  }); 
  $('.month_styled').change(function(event) {
      $('#select8').html($('.month_styled option:selected').text());
  });       
  $('.date_styled').change(function(event) {
      $('#select7').html($('.date_styled option:selected').text());
  });   
  $('#member_form_state').change(function(event) {
      $('#select10').html($('#member_form_state option:selected').text());
  }); 
  $('#member_gender').change(function(event) {
      $('#select6').html($('#member_gender option:selected').text());
  });  
  $('#member_state').change(function(event) {
      $('#select10').html($('#member_state option:selected').text());
  });      
});
