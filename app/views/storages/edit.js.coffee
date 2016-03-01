#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  storage_modal = $('#storage-modal')

  storage_modal.html(
    "<%= escape_javascript(render partial: 'storages/form/scaffold') %>"
  )

  $.get
    url: '<%= edit_storage_path(@storage.id) %>',
    data:
      sub_action: 'refresh_nested',
    dataType: 'script',

  storage_modal.modal('show')

  storage_modal.find('.modal-footer').on 'click', 'input[type="submit"]', ->
    storage_modal.modal('hide')
