#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  content_modal = $('#content-modal')

  content_modal.html(
    "<%= escape_javascript(render(partial: 'contents/form/scaffold')) %>"
  )

  $.get
    url: '<%= edit_content_path(@content.id) %>',
    data:
      sub_action: 'refresh_nested',
    dataType: 'script',

  content_modal.modal('show')

  content_modal.find('.modal-footer').on 'click', 'input[type="submit"]', ->
    content_modal.modal('hide')
