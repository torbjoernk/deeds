$ ->
  nested_fields_container = $('#nested-fields')

  # hide all tooltips
  $('[data-toggle="tooltip"]').tooltip('hide')

  # empty and re-fill the nested form
  nested_fields_container.empty()
  nested_fields_container.
    prepend('<%= escape_javascript(render(partial: 'contents/form/nested_fields')) %>')

  # refresh button
  nested_fields_container.find('#btn-refresh-nested-fields').click ->
    $.get
      url: '<%= edit_content_path(@content.id) %>',
      data:
        sub_action: 'refresh_nested',
      dataType: 'script'

  nested_fields_container.find('#btn-add-new-content-translation').click ->
    $.get(
      url: '<%= new_content_content_translation_path(content_id: @content.id) %>',
      dataType: 'html'
    )
    .done (data) ->
      $('#content-content-translations-accordion').append ->
        data
      $('#content-content-translations-accordion').find('#btn-content-translation-create-new').click ->
        $.ajax(
          url: '<%= content_content_translations_path(content_id: @content.id) %>'
          method: 'POST'
          dataType: 'script'
          data:
            utf8: $('input[name="utf8"]').val()
            authenticity_token: $('input[name="authenticity_token"]').val()
            content_translation:
              language: $('#new_content_translation').find('#content_translation_language').val()
              translation: $('#new_content_translation').find('#content_translation_translation').val()
              content_id: '<%= @content.id %>'
        )
      $('#content-content-translations-accordion').find('#btn-content-translation-abort-new').click ->
        $('#content-content-translations-accordion').find('form#new_content_translation').remove()

  # reload tooltips
  nested_fields_container.find('[data-toggle="tooltip"]').tooltip()
