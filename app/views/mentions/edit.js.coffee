#= depend_on jquery2
#= depend_on common/form_modal

$ ->
  DeedsApp.display_form_modal(
    '<%= escape_javascript(render partial: 'mentions/form/form_modal') %>'
  )
  $.get(
    url: '<%= edit_mention_path(@mention) %>'
    dataType: 'script'
    data:
      sub_action: 'form_events'
  )
