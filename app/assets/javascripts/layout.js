jQuery(document).ready(function() {
  jQuery('.footer .arrow-forward').on('click', function() {
    var imagesLength = jQuery('.footer .enlitened-being-images').length;
    var firstImage = jQuery('.footer .show-image').first();
    var lastImageId = jQuery('.footer .show-image').last().data('imageId');
    var nextImageId = (parseInt(lastImageId) + 1).toString();
    var showImage = jQuery('.footer .enlitened-being-images[data-image-id="' + nextImageId + '"]');
    if(parseInt(nextImageId) <= imagesLength){
      firstImage.removeClass('show-image').addClass('hide');
      showImage.addClass('show-image').removeClass('hide');
    }
  });

  jQuery('.footer .arrow-backward').on('click', function() {
    var firstImageId = jQuery('.footer .show-image').first().data('imageId');
    var lastImage = jQuery('.footer .show-image').last();
    var previousImageId = (parseInt(firstImageId) - 1).toString();
    var showImage = jQuery('.footer .enlitened-being-images[data-image-id="' + previousImageId + '"]');
    if(parseInt(previousImageId) >= 1){
      lastImage.removeClass('show-image').addClass('hide');
      showImage.addClass('show-image').removeClass('hide');
    };
  });
});
