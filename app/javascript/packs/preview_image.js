$(function() {
  var imagesPreview = function(input, placeToInsertImagePreview) {
    $(placeToInsertImagePreview).html('');
    if (input.files) {
      var filesAmount = input.files.length;
      for (i = 0; i < filesAmount; i++) {
        var reader = new FileReader();
        reader.onload = function(event) {
          $($.parseHTML('<img>')).attr('src', event.target.result).appendTo(placeToInsertImagePreview);
        }
        reader.readAsDataURL(input.files[i]);
      }
    }
  };
  $('#book_images').on('change', function() {
    imagesPreview(this, 'div.gallery');
  });
});
