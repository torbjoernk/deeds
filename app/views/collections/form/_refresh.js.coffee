$ ->
  nested_fields_container = $('#nested-fields')

  # hide all tooltips
  $('[data-toggle="tooltip"]').tooltip('hide')

  # empty and re-fill the nested form
  nested_fields_container.empty()
  nested_fields_container.
    append('<%= escape_javascript(render(partial: 'collections/form/nested_document_fields')) %>')
  nested_fields_container.
    append('<%= escape_javascript(render(partial: 'collections/form/nested_storage_fields')) %>')

  # refresh button
  nested_fields_container.find('#btn-refresh-nested-fields').click ->
    $.get
      url: '<%= edit_collection_path(@collection.id) %>',
      data:
        sub_action: 'refresh_nested',
      dataType: 'script',

  # rich handling of adding documents
  add_document_assoc = nested_fields_container.find('#associate-document-add')
  document_input = add_document_assoc.find('input#assoc-document-input')
  valid_document_inputs = <%= raw @free_documents.to_a.map { |x| "#{x.title} (#{x.document_type})" }.to_json %>
  document_input_id_map = <%= raw @free_documents.to_a.map { |x| {"#{x.title} (#{x.document_type})" => x.id} }.reduce({}, :update).to_json %>

  document_input.change ->
    $(this).removeClass('form-control-success').removeClass('form-control-danger')
    $(this).parent().removeClass('has-success').removeClass('has-danger')
    if $(this).prop('value') in valid_document_inputs
      $(this).addClass('form-control-success')
      $(this).parent().addClass('has-success')
    else
      $(this).addClass('form-control-danger')
      $(this).parent().addClass('has-danger')

  add_document_assoc.find('#btn-show-selected-document-details').click ->
    value = document_input.prop('value')
    if value in valid_document_inputs
      $.get
        url: '/documents/' + document_input_id_map[value]
        dataType: 'script'
    else
      alert 'no Document selected'

  add_document_assoc.find('#btn-associate-selected-document').click ->
    value = document_input.prop('value')
    if value in valid_document_inputs
      $.ajax
        url: '<%= collection_path(@collection.id) %>'
        type: 'PATCH'
        data:
          sub_action: 'associate'
          document_id: document_input_id_map[value]
        dataType: 'script'
    else
      alert 'no Document selected'

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
        url: '<%= collection_path(@collection.id) %>'
        type: 'PATCH'
        data:
          sub_action: 'associate'
          storage_id: storage_input_id_map[value]
        dataType: 'script'
    else
      alert 'no Storage selected'

  # reload tooltips
  nested_fields_container.find('[data-toggle="tooltip"]').tooltip()
