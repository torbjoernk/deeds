$ ->
  nested_fields_container = $('#archive-form-nested-fields')

  # hide all tooltips
  $('[data-toggle="tooltip"]').tooltip('hide')

  # empty and re-fill the nested form
  nested_fields_container.empty()
  nested_fields_container.append('<%= escape_javascript(render partial: 'archives/form/nested_source_fields') %>')
  nested_fields_container.append('<%= escape_javascript(render partial: 'archives/form/nested_storage_fields') %>')

  # refresh button
  nested_fields_container.find('#btn-refresh-nested-fields').click ->
    $.get
      url: '<%= edit_archive_path(@archive.id) %>',
      data:
        sub_action: 'refresh_nested',
      dataType: 'script',

  # rich handling of adding sources
  add_source_assoc = nested_fields_container.find('#associate-source-add')
  source_input = add_source_assoc.find('input#assoc-source-input')
  valid_source_inputs = <%= raw @free_sources.to_a.map { |x| "#{x.title} (#{x.source_type})" }.to_json %>
  source_input_id_map = <%= raw @free_sources.to_a.map { |x| {"#{x.title} (#{x.source_type})" => x.id} }.reduce({}, :update).to_json %>

  source_input.change ->
    $(this).removeClass('form-control-success').removeClass('form-control-danger')
    $(this).parent().removeClass('has-success').removeClass('has-danger')
    if $(this).prop('value') in valid_source_inputs
      $(this).addClass('form-control-success')
      $(this).parent().addClass('has-success')
    else
      $(this).addClass('form-control-danger')
      $(this).parent().addClass('has-danger')

  add_source_assoc.find('#btn-show-selected-source-details').click ->
    value = source_input.prop('value')
    if value in valid_source_inputs
      $.get
        url: '/sources/' + source_input_id_map[value]
        dataType: 'script'
    else
      alert 'no Source selected'

  add_source_assoc.find('#btn-associate-selected-source').click ->
    value = source_input.prop('value')
    if value in valid_source_inputs
      $.ajax
        url: '<%= archive_path(@archive.id) %>'
        type: 'PATCH'
        data:
          sub_action: 'associate'
          source_id: source_input_id_map[value]
        dataType: 'script'
    else
      alert 'no Source selected'

  # rich handling of adding storages
  add_storage_assoc = nested_fields_container.find('#associate-storage-add')
  storage_input = add_storage_assoc.find('input#assoc-storage-input')
  valid_storage_inputs = <%= raw @free_storages.to_a.map { |x| x.title }.to_json %>
  storage_input_id_map = <%= raw @free_storages.to_a.map { |x| {x.title => x.id} }.reduce({}, :update).to_json %>

  storage_input.change ->
    $(this).removeClass('form-control-success').removeClass('form-control-danger')
    $(this).parent().removeClass('has-success').removeClass('has-danger')
    if $(this).prop('value') in valid_storage_inputs
      $(this).addClass('form-control-success')
      $(this).parent().addClass('has-success')
    else
      $(this).addClass('form-control-danger')
      $(this).parent().addClass('has-danger')

  add_storage_assoc.find('#btn-show-selected-storage-details').click ->
    value = storage_input.prop('value')
    if value in valid_storage_inputs
      $.get
        url: '/storages/' + storage_input_id_map[value]
        dataType: 'script'
    else
      alert 'no Storage selected'

  add_storage_assoc.find('#btn-associate-selected-storage').click ->
    value = storage_input.prop('value')
    if value in valid_storage_inputs
      $.ajax
        url: '<%= archive_path(@archive.id) %>'
        type: 'PATCH'
        data:
          sub_action: 'associate'
          storage_id: storage_input_id_map[value]
        dataType: 'script'
    else
      alert 'no Storage selected'

  # reload tooltips
  nested_fields_container.find('[data-toggle="tooltip"]').tooltip()
