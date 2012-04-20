
  function hide_image(){
    $(".chooseImgBtn").hide();
    $(".chooseImgBtnNoBackground").show();
    var full_path_of_image = $("#files")[0].value;
    var index_of_last_slash = full_path_of_image.lastIndexOf("\\");
    var image_name = full_path_of_image.substring(index_of_last_slash+1,full_path_of_image.length)
    $(".chooseImgBtnNoBackground").html(image_name.substring(0,25));
  }


  function change_question_value(parameter){
    $('#selected_question').val(parameter);
    $('#question_button_no').val(parameter);
    $.ajax({
      type: "post",
      url: "/retrive_question_information",
      data: { question_no: parameter},
      datatype: 'json',
      success: function(json){
        if ( json['question'] ){
          $("#question_b").val(json['question']['title']);
          $("#question_b").css('color',json['question']['font_color']);
          $("#question_b").css('font-family',json['question']['font_style']);
        }
        else{
          $("#question_b").val("QUESTION " + parameter);
          $("#question_b").css('color','#34282C');
        }
      }
    });
   }


  function save_question_value(){
      var question_no =  $('#question_no').val();
      var title  = $('#question_b').val();
      var font = $('#fontSel').val();
      var font_color = $('#question_b').css('color');
      $('#question_no').val(question_no);
      $('#title').val(title);
      $('#font_style').val(font);
      $('#text_font_color').val(font_color);
      $('#image_upload_question_id').submit();
  }

  function save_bottom_banner(){
      var font_color = $('#bottomBannerBlock').css('background-color');
      $('#font_color').val(font_color);
      $('#bottom_baner_save_bottom_banner').submit();
  }



  $(document).ready(function(){
    $('#quizBlock').css('background-color','none' );
    $('#question_a').focus(function(){
      $('#question_a').css('background','none');
      $('#question_a').keyup(function(){
        $('#question_b').val($('#question_a').val());
      })
    })	

    $('#question_a').focusout(function(){
      if($('#question_a').val()=='') {
        $('#question_b').val('')
          $('#question_a').css({'background':'url("images/quesPanelImg1.jpg") no-repeat scroll left top transparent','text-align':'center'});
          $('#question_b').val('QUESTION');
      }
    })

    $('#question_b').focus(function(){
      $('#question_a').css('background','none');
      if($('#question_b').val()=='') {
        $('#question_b').val('QUESTION')
      }
      if($('#question_b').val()=='QUESTION') {
        $('#question_b').val('')
      }
      $('#question_b').keyup(function(){
        $('#question_a').val($('#question_b').val());
      })
    })	

    $('#question_b').focusout(function(){
      if($('#question_b').val()=='') {
        $('#question_a').css('background','url("images/quesPanelImg1.jpg") no-repeat scroll left top transparent');
        $('#question_b').val('QUESTION');
      }
    })
    $('#fontSel').fontSelector();
    $('#fontSel').focusout(function(){
      if($('#fontSel').val()==''){
        $('#fontSel').css('background','url("images/quesPanelImg3.jpg") no-repeat scroll left top transparent');				
      }
      else{
        $('#fontSel').css('background','none');
      }
    })

    $('#colorSelector').ColorPicker({
      color: '#000000',
      onShow: function (colpkr) {
        $(colpkr).fadeIn(500);
        return false;
      },
      onHide: function (colpkr) {
        $(colpkr).fadeOut(500);
        return false;
      },
       onChange: function (hsb, hex, rgb) {
          $('#question_b').css('color','#'+hex);
      }
    });

    $('#resetQ').click(function(){
      $('#question_a').val('')
      $('#question_b').val('')
      $('#fontSel').val('')
      $('#question_a').css({'background':'url("images/quesPanelImg1.jpg") no-repeat scroll left top transparent'});
      $('#question_b').css({'font-family':'inherit','color':'#000000'});
      $('#question_b').val('QUESTION');
      $('#fontSel').css('background','url("../images/quesPanelImg3.jpg") no-repeat scroll left top transparent');
    });
  });
