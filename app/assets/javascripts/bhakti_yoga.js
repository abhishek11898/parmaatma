jQuery(document).ready(function() {
  jQuery('#load-more').on('click', function() {
    var totalRecord = jQuery('.yoga-marg-container .card-container').attr('total-records');
    jQuery.ajax({
      url: '/bhakti_yogas/get_more_bhakti_yoga_record_by_ajax',
      method: 'GET',
      dataType: 'json',
      data: { total_record: totalRecord},
    });
  });
});
  