#= depend_on common/show_modal

$ ->
  DeedsApp.display_show_modal(
    "<%= escape_javascript(render partial: 'shared/show/title', locals: { entity: @person }) %>",
    "<%= escape_javascript(render partial: 'people/show/content', locals: { native: true }) %>",
    "<%= escape_javascript(render partial: 'shared/show/footer') %>"
  )
