#= depend_on common/show_modal

$ ->
  DeedsApp.display_show_modal(
    "<%= escape_javascript(render partial: 'shared/show/title', locals: { entity: @mention_entry }) %>",
    "<%= escape_javascript(render partial: 'mention_entries/show/content', locals: { native: true }) %>",
    "<%= escape_javascript(render partial: 'shared/show/footer',
                                  locals: { edit_link_path: edit_mention_entry_path(@mention_entry) }) %>"
  )
