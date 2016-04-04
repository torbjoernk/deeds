$ ->
  nested_fields_container = $('#nested-fields')

  # hide all tooltips
  $('[data-toggle="tooltip"]').tooltip('hide')

  # empty and re-fill the nested form
  nested_fields_container.empty()
  nested_fields_container.
  prepend('<%= escape_javascript(render(partial: 'deeds/form/nested_fields')) %>')

  # refresh button
  nested_fields_container.find('#btn-refresh-nested-fields').click ->
    $.get
      url: '<%= edit_deed_path(@deed.id) %>',
      data:
        sub_action: 'refresh_nested',
      dataType: 'script',

  <% unless @deed.content.nil? %>
  nested_fields_container.find('#btn-deassoc-content').click ->
    if confirm '<%= t('helpers.confirmation.delete') %>'
      $.ajax
        url: '<%= deed_path(@deed.id) %>',
        type: 'PATCH',
        data:
          sub_action: 'deassoc_content',
          content_id: <%= @deed.content.id %>,
        dataType: 'script'
  <% end %>

  # reload tooltips
  nested_fields_container.find('[data-toggle="tooltip"]').tooltip()
