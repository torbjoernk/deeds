#= depend_on common/show_modal

$ ->
  DeedsApp.display_show_modal(
    "<%= escape_javascript(render partial: 'shared/show/title', locals: { entity: @author }) %>",
    "<%= escape_javascript(render partial: 'authors/show/content', locals: { native: true }) %>",
    "<%= escape_javascript(render partial: 'shared/show/footer',
                                  locals: { edit_link_path: edit_author_path(@author) }) %>"
  )
