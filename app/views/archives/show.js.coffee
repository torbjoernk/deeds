#= depend_on common/show_modal

$ ->
  DeedsApp.display_show_modal(
    "<%= escape_javascript(render partial: 'archives/show/title') %>",
    "<%= escape_javascript(render partial: 'archives/show/content') %>"
  )
