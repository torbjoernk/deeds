#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  table = $('#places-table')
  table.find('.table-body')
    .empty()
    .html('<%= escape_javascript(render partial: 'place', collection: @places) %>')
