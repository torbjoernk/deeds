#= depend_on jquery2
#= depend_on bootstrap/bootstrap
#= depend_on pre_load

DeedsApp.display_show_modal = (title, content, footer) ->
  show_modal = $('#show-modal')
  show_modal.find('#show-modal-title').html(title)
  show_modal.find('#show-modal-content').html(content)
  show_modal.find('#show-modal-footer').html(footer)
  show_modal.modal('show')
  show_modal.find('[data-toggle="toolip"]').tooltip()
