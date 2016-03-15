#= depend_on common/show_modal

$ ->
  DeedsApp.display_show_modal(
    "<%= escape_javascript(render partial: 'shared/show/title', locals: { entity: @content_translation }) %>",
    "<%= escape_javascript(render partial: 'content_translations/show/content', locals: { native: true }) %>"
  )
