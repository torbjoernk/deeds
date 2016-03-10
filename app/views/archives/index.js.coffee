#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  table = $('#archives-table')
  table.find('.table-body')
    .empty()
    .html('<%= escape_javascript(render partial: 'archive', collection: @archives) %>')
