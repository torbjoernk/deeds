#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  $('#content-translation-modal').html(
    "<%= escape_javascript(render(partial: 'content_translations/show')) %>"
  ).modal('show')
