$ ->
  nested_fields_container = $('#content-form-nested-fields')

  # hide all tooltips
  $('[data-toggle="tooltip"]').tooltip('hide')

<% if defined? deleted_translation_id %>
  console.log('Deleted Content Translation: ' + <%= deleted_translation_id %>)
  nested_fields_container.
    find("#associated-content-translation-<%= deleted_translation_id %>").
    remove()
<% end %>

  $('#btn-add-new-content-translation').click ->
    $('#associate-content-translations').append ->
      '<%= escape_javascript(render(partial: 'contents/form/translation_form')) %>'

  # reload tooltips
  nested_fields_container.find('[data-toggle="tooltip"]').tooltip()
