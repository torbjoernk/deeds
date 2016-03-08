#= depend_on jquery2
#= depend_on common/form_modal

$ ->
  DeedsApp.display_form_modal "<%= escape_javascript(render partial: 'sources/form/form_modal') %>", ->
    $.get
      url: '<%= edit_source_path(@source.id) %>',
      data:
        sub_action: 'refresh_nested',
      dataType: 'script',
