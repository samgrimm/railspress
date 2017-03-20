function showImageDiv(elementId) {
  var text = $('#typeField').val();
  if (text == 'Text') {
    $('#text-fields').css({'display':'block'});
    $('#image_fields').css({'display':'none'});
  } else {
    $('#text-fields').css({'display':'none'});
    $('#image_fields').css({'display':'block'});
  }
}
