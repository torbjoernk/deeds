#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  table = $('#deeds-table')
  table.find('.table-body')
    .empty()
    .html('<%= escape_javascript(render partial: 'deed', collection: @deeds) %>')