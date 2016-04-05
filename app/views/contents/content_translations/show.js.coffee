#= depend_on common/show_modal

$ ->
  DeedsApp.display_show_modal(
    "<%= escape_javascript(render partial: 'shared/show/title',
                                  locals: { entity: @content_translation }) %>",
    "<%= escape_javascript(render partial: 'contents/content_translations/show/content',
                                  locals: { native: true }) %>",
    "<%= escape_javascript(render partial: 'shared/show/footer',
                                  locals: {
                                    edit_link_path:
                                      edit_content_content_translation_path(id: @content_translation.id,
                                                                            content: @content_translation.content)
                                  }
                          ) %>"
  )
