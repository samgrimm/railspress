$(document).ready(function() {
  $("#widget_type").change(function() {
    var text = $('#widget_type').val();
    if (text == 'Text') {
      $('#text-fields').css({'display':'block'});
      $('#image_fields').css({'display':'block'});
    } else {
      $('#image_fields').css({'display':'block'});
      $('#text-fields').css({'display':'none'});
    }
  });
});
