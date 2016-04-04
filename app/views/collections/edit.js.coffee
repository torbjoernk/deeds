#= depend_on jquery2
#= depend_on common/form_modal

$ ->
  DeedsApp.display_form_modal_with_ajax_url(
    '<%= escape_javascript(render partial: 'collections/form/form_modal') %>',
    '<%= edit_collection_path(@collection.id) %>'
  )
