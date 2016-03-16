#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  table = $('#people-table')
  table.find('.table-body')
    .empty()
    .html('<%= escape_javascript(render partial: 'person', collection: @people) %>')
