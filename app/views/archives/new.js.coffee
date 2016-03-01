#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  archive_modal = $('#archive-modal')

  archive_modal.html(
    "<%= escape_javascript(render partial: 'archives/form/scaffold') %>"
  )

  archive_modal.modal('show')

  archive_modal.find('.modal-footer').on 'click', 'input[type="submit"]', ->
    archive_modal.modal('hide')
