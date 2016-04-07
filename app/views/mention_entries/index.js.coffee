#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  table = $('#mention_entries-table')
  table.find('.table-body')
    .empty()
    .html('<%= escape_javascript(render partial: 'mention_entry', collection: @mention_entries) %>')
