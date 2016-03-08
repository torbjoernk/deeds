#= depend_on common/show_modal

$ ->
  DeedsApp.display_show_modal(
    "<%= escape_javascript(render partial: 'shared/show/title', locals: { entity: @source }) %>",
    "<%= escape_javascript(render partial: 'sources/show/content') %>"
  )
