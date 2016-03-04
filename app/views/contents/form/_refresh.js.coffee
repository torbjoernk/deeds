$ ->
  nested_fields_container = $('#content-form-nested-fields')

  # hide all tooltips
  $('[data-toggle="tooltip"]').tooltip('hide')

  # empty and re-fill the nested form
  nested_fields_container.empty()
  nested_fields_container.
    prepend('<%= escape_javascript(render(partial: 'contents/form/nested_fields')) %>')

  # refresh button
  nested_fields_container.find('#btn-refresh-nested-fields').click ->
    $.get
      url: '<= edit_content_path(@content.id) %>',
      data:
        sub_action: 'refresh_nested',
      dataType: 'script',

  # rich handling of adding content_translations
  add_content_translation_assoc = nested_fields_container.find('#associate-content-translation-add')
  content_translation_input = add_content_translation_assoc.find('input#assoc-content-translation-input')
  valid_inputs = <%= raw @unassociated[:content_translations].to_a.map { |x| x.language }.to_json %>
  input_id_map = <%= raw @unassociated[:content_translations].to_a.map { |x| {x.language => x.id} }.reduce({}, :update).to_json %>

  content_translation_input.change ->
    $(this).removeClass('form-control-success').removeClass('form-control-danger')
    $(this).parent().removeClass('has-success').removeClass('has-danger')
    if $(this).prop('value') in valid_inputs
      $(this).addClass('form-control-success')
      $(this).parent().addClass('has-success')
    else
      $(this).addClass('form-control-danger')
      $(this).parent().addClass('has-danger')

  add_content_translation_assoc.find('#btn-show-selected-content-translation-details').click ->
    value = content_translation_input.prop('value')
    if value in valid_inputs
      $.get
        url: '/content_translations/' + input_id_map[value]
        dataType: 'script'
    else
      alert 'no Content Translation selected'

  add_content_translation_assoc.find('#btn-associate-selected-content-translation').click ->
    value = content_translation_input.prop('value')
    if value in valid_inputs
      $.ajax
        url: '<%= content_path(@content.id) %>'
        type: 'PATCH'
        data:
          sub_action: 'associate'
          content_translation_id: input_id_map[value]
        dataType: 'script'
    else
      alert 'no Content Translation selected'

  # reload tooltips
  nested_fields_container.find('[data-toggle="tooltip"]').tooltip()
