    $(".zoom").click(function() {//control panel
      var view = $("#viewport1");
      view.mapbox('zoom', 1);//step twice
      var valore;
      valore = parseInt($("#slider01").slider('value')) + 1;
      $("#slider01").slider('value', valore);
      $('#slider').val(valore);
      return false;
    });

    $(".resetTxt").click(function() {//control panel
      var view = $("#viewport1");
      var reset_val = parseInt($('#slider').val());
      view.mapbox('back', reset_val);
      $("#slider01").slider('value', 0);
      $('#slider').val(0);
      return false;
    });

    $("#slider01").slider({
      value:0,
      min: 0,
      max: 8,
      step: 1,
      slide: function( event, ui ) {
        var new_val = ui.value;
        var old_val = parseInt($('#slider').val());
        var viewport = $("#viewport1");
        var step;
        if (new_val > old_val)
        {
          step = new_val - old_val;
          viewport.mapbox('zoom', step);
        }
        else
        {
          step = old_val - new_val;
          viewport.mapbox('back', step);
        }
        $('#slider').val(new_val);
      }
    });

    function save_and_submit(){
      var stealCode =  $('#stealCode').val();
      var itemDesc =  $('#itemDesc').val();
      $('#description_id').val(itemDesc);
      $('#no_of_items_id').val(stealCode);
      $('#schwag_form').submit();
    }

  function hide_image(){
    $(".chooseImgBtn").hide();
    $(".chooseImgBtnNoBackground").show();
    var full_path_of_image = $("#files")[0].value;
    var index_of_last_slash = full_path_of_image.lastIndexOf("\\");
    var image_name = full_path_of_image.substring(index_of_last_slash+1,full_path_of_image.length)
    $(".chooseImgBtnNoBackground").html(image_name.substring(0,25));
  }