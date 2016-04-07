#= depend_on jquery2.js
#= depend_on common/form_modal

$ ->
  DeedsApp.display_form_modal(
    '<%= escape_javascript(render partial: 'mention/mention_entries/form/form_modal') %>'
  )
  $.get(
    url: '<%= edit_mention_mention_entry_path(@mention_entry) %>'
    dataType: 'script'
    data:
      sub_action: 'form_events'
  )
