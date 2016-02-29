#= depend_on jquery2
#= depend_on bootstrap/bootstrap

$ ->
  $('#source-modal').html(
    "<%= escape_javascript(render(partial: 'sources/show')) %>"
  ).modal('show')
