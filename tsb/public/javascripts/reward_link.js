function hide_image(){
  $(".chooseImgBtn").hide();
  $(".chooseImgBtnNoBackground").show();
  var full_path_of_image = $("#files")[0].value;
  var index_of_last_slash = full_path_of_image.lastIndexOf("\\");
  var image_name = full_path_of_image.substring(index_of_last_slash+1,full_path_of_image.length)
  $(".chooseImgBtnNoBackground").html(image_name.substring(0,25));
}
function save_and_submit(){
}
