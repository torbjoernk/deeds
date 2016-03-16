#= depend_on common/show_modal

$ ->
  DeedsApp.display_show_modal(
    "<%= escape_javascript(render partial: 'shared/show/title', locals: { entity: @content }) %>",
    "<%= escape_javascript(render partial: 'contents/show/content', locals: { native: true }) %>",
    "<%= escape_javascript(render partial: 'shared/show/footer') %>"
  )
