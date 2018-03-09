# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#users-table').dataTable
    
    processing: true
    serverSide: true
    responsive: true
    ajax: $('#users-table').data('source')
    pagingType: 'full_numbers'
    columns: [
      {data: 'name'}
      {data: 'email'}
      {data: 'created_at'}
      {data: 'updated_at'}
    ]
    # pagingType is optional, if you want full pagination controls.
    # Check dataTables documentation to learn more about
    # available options.
