#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  table = $('#roles-table')
  table.find('.table-body')
    .empty()
    .html('<%= escape_javascript(render partial: 'role', collection: @roles) %>')
