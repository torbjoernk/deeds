#= depend_on jquery2.js
#= depend_on bootstrap/bootstrap

$ ->
  table = $('#mention_entries-table')
  table.find('.table-body')
    .empty()
    .html('<%= escape_javascript(render partial: 'mention_entry', collection: @mention_entries) %>')
