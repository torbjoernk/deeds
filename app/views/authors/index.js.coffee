#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  table = $('#authors-table')
  table.find('.table-body')
    .empty()
    .html('<%= escape_javascript(render partial: 'author', collection: @authors) %>')
