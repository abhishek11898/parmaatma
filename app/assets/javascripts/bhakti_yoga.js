jQuery(document).ready(function() {
  jQuery('#load-more').on('click', function() {
    var totalRecord = jQuery('.yoga-marg-container .card-container').attr('total-records');
    var controllerName = jQuery('.card-container .card').data('controllerName');
    jQuery.ajax({
      url: '/' + controllerName + '/get_more_' + controllerName + '_record_by_ajax',
      method: 'GET',
      dataType: 'script',
      data: { total_records: totalRecord},
    });
  });
});
  