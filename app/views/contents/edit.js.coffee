#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  content_modal = $('#content-modal')

  content_modal.html(
    "<%= escape_javascript(render(partial: 'contents/form/scaffold')) %>"
  )

  content_modal.find('#btn-add-new-content-translation').click ->
    $.get(
      url: '<%= new_content_content_translation_path(content_id: @content.id) %>',
      dataType: 'html'
    )
    .done (data) ->
      $('#content-content-translations-accordion').append ->
        data
      $('#content-content-translations-accordion')
      .find('#btn-content-translation-create-new').click ->
        $.ajax(
          url: '<%= content_content_translations_path(content_id: @content.id) %>'
          method: 'POST'
          dataType: 'js'
          data:
            utf8: $('input[name="utf8"]').val()
            authenticity_token: $('input[name="authenticity_token"]').val()
            content_translation:
              language: $('#new_content_translation').find('#content_translation_language').val()
              translation: $('#new_content_translation').find('#content_translation_translation').val()
              content_id: '<%= @content.id %>'
        )

  content_modal.modal('show')

  content_modal.find('.modal-footer').on 'click', 'input[type="submit"]', ->
    content_modal.modal('hide')
