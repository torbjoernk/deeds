#= depend_on common/show_modal

$ ->
  DeedsApp.display_show_modal(
    "<%= escape_javascript(render partial: 'shared/show/title', locals: { entity: @storage }) %>",
    "<%= escape_javascript(render partial: 'storages/show/content', locals: { native: true }) %>"
  )
