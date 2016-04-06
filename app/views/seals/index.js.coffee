#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  table = $('#seals-table')
  table.find('.table-body')
    .empty()
    .html('<%= escape_javascript(render partial: 'seal', collection: @seals) %>')
