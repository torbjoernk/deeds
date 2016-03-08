#= depend_on jquery2
#= depend_on bootstrap/bootstrap
#= depend_on pre_load

DeedsApp.display_show_modal = (title, content) ->
  show_modal = $('#show-modal')
  show_modal.find('#show-modal-title').html(title)
  show_modal.find('#show-modal-content').html(content)
  show_modal.modal('show')
