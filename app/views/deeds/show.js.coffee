#= depend_on common/show_modal

$ ->
  DeedsApp.display_show_modal(
    "<%= escape_javascript(render partial: 'shared/show/title', locals: { entity: @deed }) %>",
    "<%= escape_javascript(render partial: 'deeds/show/content', locals: { native: true }) %>"
  )
