#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  storage_modal = $('#storage-modal')

  storage_modal.find('.modal-dialog').addClass('modal-lg')

  storage_modal.html(
    "<%= escape_javascript(render(partial: 'storages/form/scaffold')) %>"
  )

  storage_modal.modal('show')

  storage_modal.find('.modal-footer').on 'click', 'input[type="submit"]', ->
    storage_modal.modal('hide')
