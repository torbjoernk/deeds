#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  table = $('#storages-table')
  table.find('.table-body')
    .empty()
    .html('<%= escape_javascript(render partial: 'storage', collection: @storages) %>')
