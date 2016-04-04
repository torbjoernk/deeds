$ ->
  nested_fields_container = $('#nested-fields')

  # hide all tooltips
  $('[data-toggle="tooltip"]').tooltip('hide')

  # empty and re-fill the nested form
  nested_fields_container.empty()
  nested_fields_container.
    prepend('<%= escape_javascript(render(partial: 'storages/form/nested_fields')) %>')

  # refresh button
  nested_fields_container.find('#btn-refresh-nested-fields').click ->
    $.get
      url: '<%= edit_storage_path(@storage.id) %>',
      data:
        sub_action: 'refresh_nested',
      dataType: 'script',

  # rich handling of adding collections
  add_collection_assoc = nested_fields_container.find('#associate-collection-add')
  collection_input = add_collection_assoc.find('input#assoc-collection-input')
  valid_inputs = <%= raw @unassociated[:collections].to_a.map { |x| x.title }.to_json %>
  input_id_map = <%= raw @unassociated[:collections].to_a.map { |x| {x.title => x.id} }.reduce({}, :update).to_json %>

  collection_input.change ->
    $(this).removeClass('form-control-success').removeClass('form-control-danger')
    $(this).parent().removeClass('has-success').removeClass('has-danger')
    if $(this).prop('value') in valid_inputs
      $(this).addClass('form-control-success')
      $(this).parent().addClass('has-success')
    else
      $(this).addClass('form-control-danger')
      $(this).parent().addClass('has-danger')

  add_collection_assoc.find('#btn-show-selected-collection-details').click ->
    value = collection_input.prop('value')
    if value in valid_inputs
      $.get
        url: '/storages/' + input_id_map[value]
        dataType: 'script'
    else
      alert <%= t('views.collection.none_selected') %>

  add_collection_assoc.find('#btn-associate-selected-collection').click ->
    value = collection_input.prop('value')
    if value in valid_inputs
      $.ajax
        url: '<%= storage_path(@storage.id) %>'
        type: 'PATCH'
        data:
          sub_action: 'associate'
          collection_id: input_id_map[value]
        dataType: 'script'
    else
      alert <%= t('views.collection.none_selected') %>

  # reload tooltips
  nested_fields_container.find('[data-toggle="tooltip"]').tooltip()
