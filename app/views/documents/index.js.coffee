#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  table = $('#documents-table')
  table.find('.table-body')
    .empty()
    .html('<%= escape_javascript(render partial: 'document', collection: @documents) %>')
