#= depend_on jquery2
#= depend_on bootstrap/bootstrap
#= depend_on pre_load

DeedsApp.display_form_modal = (title, content, submit, callback) ->
  $('[data-toggle="tooltip"]').tooltip('dispose')
  form_modal = $('#form-modal')
  form_modal.find('#form-modal-title').html(title)
  form_modal.find('#form-modal-content').html(content)
  form_modal.find('#form-modal-submit').html(submit)
  if callback?
    callback(form_modal)
  form_modal.modal('show')
  form_modal.find('[data-toggle="toolip"]').tooltip()
  form_modal.on 'click', 'input[type="submit"]', ->
    form_modal.modal('hide')

DeedsApp.display_form_modal = (full_modal, callback) ->
  $('[data-toggle="tooltip"]').tooltip('dispose')
  form_modal = $('#form-modal')
  form_modal.html(full_modal)
  if callback?
    callback(form_modal)
  form_modal.modal('show')
  form_modal.find('[data-toggle="toolip"]').tooltip()
  form_modal.on 'click', 'input[type="submit"]', ->
    form_modal.modal('hide')

DeedsApp.display_form_modal_with_ajax_url = (full_modal, callback_url) ->
  DeedsApp.display_form_modal full_modal, ->
    $.get
      url: callback_url,
      data:
        sub_action: 'refresh_nested',
      dataType: 'script',
