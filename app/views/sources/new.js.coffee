#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  source_modal = $('#source-modal')

  source_modal.html(
    "<%= escape_javascript(render(partial: 'sources/form')) %>"
  ).modal('show')

  source_modal.find('.modal-footer').on 'click', 'input[type="submit"]', ->
    source_modal.modal('hide')
