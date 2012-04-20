  function hide_image(){
    $(".chooseImgBtn").hide();
    $(".chooseImgBtnNoBackground").show();
    var full_path_of_image = $("#files")[0].value;
    var index_of_last_slash = full_path_of_image.lastIndexOf("\\");
    var image_name = full_path_of_image.substring(index_of_last_slash+1,full_path_of_image.length)
    $(".chooseImgBtnNoBackground").html(image_name.substring(0,25));
  }

  function save_and_submit(){
    var regPrice =  $('#regPrice').val();
    var salPrice =  $('#salPrice').val();
    var itemDesc =  $('#itemDesc').val();
    var stealCode =  $('#stealCode').val();
    var eComLink =  $('#eComLink').val();
    $('#reg_price_id').val(regPrice);
    $('#sal_price_id').val(salPrice);
    $('#description_id').val(itemDesc);
    $('#code_id').val(stealCode);
    $('#e_commerce_link_id').val(eComLink);
    $('#steal_form').submit();
  }