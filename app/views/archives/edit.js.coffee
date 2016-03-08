#= depend_on jquery2
#= depend_on common/form_modal

$ ->
  DeedsApp.display_form_modal "<%= escape_javascript(render partial: 'archives/form/form_modal') %>", ->
    $.get
      url: '<%= edit_archive_path(@archive.id) %>',
      data:
        sub_action: 'refresh_nested',
      dataType: 'script',
