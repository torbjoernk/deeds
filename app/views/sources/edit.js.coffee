#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  source_modal = $('#source-modal')

  source_modal.html(
    "<%= escape_javascript(render(partial: 'sources/form/scaffold')) %>"
  )

  $.get
    url: '<%= edit_source_path(@source.id) %>',
    data:
      sub_action: 'refresh_nested',
    dataType: 'script',

  source_modal.modal('show')

  source_modal.find('.modal-footer').on 'click', 'input[type="submit"]', ->
    source_modal.modal('hide')
