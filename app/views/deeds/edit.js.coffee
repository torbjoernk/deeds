#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  deed_modal = $('#deed-modal')

  deed_modal.html(
    "<%= escape_javascript(render(partial: 'deeds/form/scaffold')) %>"
  )

  $.get
    url: '<%= edit_deed_path(@deed.id) %>',
    data:
      sub_action: 'refresh_nested',
    dataType: 'script',

  deed_modal.modal('show')

  deed_modal.find('.modal-footer').on 'click', 'input[type="submit"]', ->
    deed_modal.modal('hide')
