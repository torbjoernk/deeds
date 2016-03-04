#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  content_translation_modal = $('#content-translation-modal')

  content_translation_modal.find('.modal-dialog').addClass('modal-lg')

  content_translation_modal.html(
    "<%= escape_javascript(render(partial: 'content_translations/form/scaffold')) %>"
  )

  content_translation_modal.modal('show')

  content_translation_modal.find('.modal-footer').on 'click', 'input[type="submit"]', ->
    content_translation_modal.modal('hide')
