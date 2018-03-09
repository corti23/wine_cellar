// users.js

/*
jQuery(document).ready(function() {
  $('#users-table').dataTable({

    language: getLanguage('$('body').data('locale')'),
    "processing": true,
    "serverSide": true,
    "ajax": $('#users-table').data('source'),
    "pagingType": "full_numbers",
    "columns": [
      {"data": "name"},
      {"data": "email"},
      {"data": "created_at"},
      {"data": "updated_at"}
    ]
    // pagingType is optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });
});
*/

function initList(locale) {
	var lastsel;
	var table = $('#users-table').dataTable({
    language: getLanguage(locale),
    dom: 'Blfrtip',
    buttons: [ 'colvis', 'copyHtml5' ],
    "processing": true,
    "serverSide": true,
    colReorder: 	true,
    stateSave: 		true,
    stateDuration: 60 * 60 * 24 * 8,
    scrollY:      '60vh',
    scroller:     true,
    "ajax": $('#users-table').data('source'),
    "columns": [
      {"data": "name"},
      {"data": "email"},
      {"data": "created_at"},
      {"data": "updated_at"}
    ],
    "pagingType": "full_numbers"
  });

  $('#users-table tbody').on('click', 'tr', function () {
		var id = this.id;

		if(this == lastsel) {
		  $(this).toggleClass('selected');
		  lastsel=null;
		  //initButtons();
		}
		else {
			$(lastsel).toggleClass('selected');
			$(this).toggleClass('selected');
			lastsel = this
			//setButtons($('#Datatable').data('source'),id)
		}
  });
}
