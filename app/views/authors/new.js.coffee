#= depend_on common/form_modal

$ ->
  DeedsApp.display_form_modal "<%= escape_javascript(render partial: 'authors/form/form_modal') %>"
