$ ->
  nested_fields_container = $('#source-form-nested-fields')

  # hide all tooltips
  $('[data-toggle="tooltip"]').tooltip('hide')

  # empty and re-fill the nested form
  nested_fields_container.empty()
  nested_fields_container.prepend('<%= escape_javascript(render partial: 'sources/form/nested_fields') %>')

  # refresh button
  nested_fields_container.find('#btn-refresh-nested-fields').click ->
    $.get
      url: '<%= edit_source_path(@source.id) %>',
      data:
        sub_action: 'refresh_nested',
      dataType: 'script',

  # rich handling of adding archives
  add_archive_assoc = nested_fields_container.find('#associate-archive-add')
  archive_input = add_archive_assoc.find('input#assoc-archive-input')
  valid_inputs = <%= raw @free_archives.to_a.map { |x| x.title }.to_json %>
  input_id_map = <%= raw @free_archives.to_a.map { |x| {x.title => x.id} }.reduce({}, :update).to_json %>

  archive_input.change ->
    $(this).removeClass('form-control-success').removeClass('form-control-danger')
    $(this).parent().removeClass('has-success').removeClass('has-danger')
    if $(this).prop('value') in valid_inputs
      $(this).addClass('form-control-success')
      $(this).parent().addClass('has-success')
    else
      $(this).addClass('form-control-danger')
      $(this).parent().addClass('has-danger')

  add_archive_assoc.find('#btn-show-selected-archive-details').click ->
    value = archive_input.prop('value')
    if value in valid_inputs
      $.get
        url: '/archives/' + input_id_map[value]
        dataType: 'script'
    else
      alert 'no Archive selected'

  add_archive_assoc.find('#btn-associate-selected-archive').click ->
    value = archive_input.prop('value')
    if value in valid_inputs
      $.ajax
        url: '<%= source_path(@source.id) %>'
        type: 'PATCH'
        data:
          sub_action: 'associate'
          archive_id: input_id_map[value]
        dataType: 'script'
    else
      alert 'no Archive selected'


  # reload tooltips
  nested_fields_container.find('[data-toggle="tooltip"]').tooltip()
