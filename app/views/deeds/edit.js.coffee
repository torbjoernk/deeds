#= depend_on jquery2
#= depend_on common/form_modal

$ ->
  DeedsApp.display_form_modal "<%= escape_javascript(render partial: 'deeds/form/form_modal') %>", ->
    $.get
      url: '<%= edit_deed_path(@deed.id) %>',
      data:
        sub_action: 'refresh_nested',
      dataType: 'script',
