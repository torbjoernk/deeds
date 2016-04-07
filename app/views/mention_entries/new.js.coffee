#= depend_on common/form_modal

$ ->
  DeedsApp.display_form_modal "<%= escape_javascript(render partial: 'mention_entries/form/form_modal') %>"
  $.get(
    url: '<%= new_mention_entry_path %>'
    dataType: 'script'
    data:
      sub_action: 'form_events'
  )
