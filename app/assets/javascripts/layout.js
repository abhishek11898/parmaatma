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

  jQuery('.menu-bar-icon-div').on('click', function(){
    var ShowElement = jQuery('.menu-bar-icon-div').find('.show');
    var hideElement = jQuery('.menu-bar-icon-div').find('.hide');
    if(hideElement.hasClass('show-drag-and-drop')){
      jQuery('.navbar-menu').removeClass('hide');
      jQuery('.container .sign-out-btn').addClass('hide');
    }else{
      jQuery('.navbar-menu').addClass('hide');
      jQuery('.container .sign-out-btn').removeClass('hide');
    }
    ShowElement.toggleClass('show hide');
    hideElement.toggleClass('hide show');
  });

  jQuery('.card-container .card').on('click', function() {
    var controllerName = jQuery(this).data('controllerName');
    var id = jQuery(this).data('id');
    var url = '/' + controllerName + '/' + id;
    window.location.href = url;
  });

  jQuery('.aum-logo-div .aum-logo').on('click', function(){
    var url = '/admins/sign_in';
    window.location.href = url; 
  });
});
